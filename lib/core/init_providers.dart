import 'package:advanced_task_manager/offline/sqflite_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sqflite/sqflite.dart';

// 1. Provider of God (REST)
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
    ),
  );
});

// 2. GraphQL Link Provider
final graphQlHttpLinkProvider = Provider<HttpLink>((ref) {
  return HttpLink('https://countries.trevorblades.com/');
});

// 3. GraphQL Client Provider
final graphQlClientProvider = Provider<GraphQLClient>((ref) {
  final link = ref.read(graphQlHttpLinkProvider);

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: InMemoryStore(),
    ),
  );
});

// 4. Database manager provider
final databaseManagerProvider = Provider<SqFliteManager>((ref) {
  final manager = SqFliteManager.instance;

  // Close the database when ProviderScope is destroyed
  ref.onDispose(() {
    SqFliteManager.closeDatabase();
  });

  return manager;
});


/// 5. Database Instance Provider
final databaseProvider = FutureProvider<Database>((ref) async {
  final manager = ref.read(databaseManagerProvider);
  return await manager.database;
});
