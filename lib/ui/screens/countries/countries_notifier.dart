import 'package:advanced_task_manager/data/repositories/countries/country_repository.dart';
import 'package:advanced_task_manager/models/country.dart';
import 'package:flutter_riverpod/legacy.dart';

class CountriesState {
  final List<Country> countries;
  final bool isLoading;
  final String? error;

  CountriesState({
    this.countries = const [],
    this.isLoading = false,
    this.error,
  });

  CountriesState copyWith({
    List<Country>? countries,
    bool? isLoading,
    String? error,
  }) {
    return CountriesState(
      countries: countries ?? this.countries,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CountriesNotifier extends StateNotifier<CountriesState> {
  final CountryRepository repository;

  CountriesNotifier(this.repository) : super(CountriesState()) {
    loadCountries();
  }

  Future<void> loadCountries() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await repository.getCountries();
      state = state.copyWith(countries: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}