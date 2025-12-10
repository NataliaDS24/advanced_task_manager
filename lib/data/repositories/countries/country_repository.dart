import 'package:advanced_task_manager/models/country.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryRepository {
  final GraphQLClient client;

  CountryRepository(this.client);

  Future<List<Country>> getCountries() async {
    try {
      const query = r'''
        query {
          countries {
            code
            name
            emoji
          }
        }
      ''';

      final options = QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await client.query(options);

      if (result.hasException) {
        throw Exception("Error en la consulta de países.");
      }

      final data = result.data;
      if (data == null || data['countries'] == null) {
        throw Exception("La API devolvió datos vacíos o inválidos.");
      }

      final rawList = data['countries'] as List<dynamic>;
      return rawList
          .map((e) => Country.fromMap(map: e))
          .toList();

    } catch (e) {
      throw Exception("No fue posible obtener los países. Intente más tarde.");
    }
  }
}