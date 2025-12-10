import 'package:advanced_task_manager/data/repositories/countries/country_repository_provider.dart';
import 'package:advanced_task_manager/ui/screens/countries/countries_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

final countriesNotifierProvider =
    StateNotifierProvider<CountriesNotifier, CountriesState>((ref) {
  final repo = ref.read(countryRepositoryProvider);
  return CountriesNotifier(repo);
});
