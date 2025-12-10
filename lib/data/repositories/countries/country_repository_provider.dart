import 'package:advanced_task_manager/core/init_providers.dart';
import 'package:advanced_task_manager/data/repositories/countries/country_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  final client = ref.read(graphQlClientProvider);
  return CountryRepository(client);
});
