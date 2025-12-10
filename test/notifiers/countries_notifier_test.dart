import 'package:advanced_task_manager/ui/screens/countries/countries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:advanced_task_manager/models/country.dart';
import 'package:advanced_task_manager/data/repositories/countries/country_repository.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late MockCountryRepository mockRepository;

  final mockList = [
    Country(id: 'CO', name: 'Colombia', flag: '🇨🇴'),
    Country(id: 'MX', name: 'Mexico', flag: '🇲🇽'),
  ];

  setUp(() {
    mockRepository = MockCountryRepository();
  });

  group('CountriesNotifier Tests', () {
    test(
      'Constructing notifier inicia carga automáticamente y asigna países correctamente',
      () async {
        when(() => mockRepository.getCountries())
            .thenAnswer((_) async => mockList);

        final notifier = CountriesNotifier(mockRepository);

        // inmediatamente después del constructor, isLoading debe estar true
        expect(notifier.state.isLoading, true);
        expect(notifier.state.countries, isEmpty);

        // esperar resultado
        await Future.delayed(Duration.zero);

        // validar estado final
        expect(notifier.state.isLoading, false);
        expect(notifier.state.countries.length, 2);
        expect(notifier.state.error, isNull);

        verify(() => mockRepository.getCountries()).called(1);
      },
    );

    test(
      'loadCountries maneja errores y actualiza estado correctamente',
      () async {
        when(() => mockRepository.getCountries())
            .thenThrow(Exception('Error Testing'));

        final notifier = CountriesNotifier(mockRepository);

        // loading inicial
        expect(notifier.state.isLoading, true);

        // esperar a que termine el future
        await Future.delayed(Duration.zero);

        expect(notifier.state.isLoading, false);
        expect(notifier.state.countries, isEmpty);
        expect(notifier.state.error, contains('Exception'));

        verify(() => mockRepository.getCountries()).called(1);
      },
    );

    test(
      'loadCountries puede ser llamado manualmente y funciona bien en éxito',
      () async {
        when(() => mockRepository.getCountries())
            .thenAnswer((_) async => mockList);

        final notifier = CountriesNotifier(mockRepository);

        // Se ejecuta una vez en el constructor
        await Future.delayed(Duration.zero);

        // Preparar nuevo mock para segunda llamada
        when(() => mockRepository.getCountries())
            .thenAnswer((_) async => mockList);

        await notifier.loadCountries();

        expect(notifier.state.isLoading, false);
        expect(notifier.state.countries.length, 2);
        expect(notifier.state.error, isNull);

        // Se llamó 2 veces: en constructor y en esta llamada manual
        verify(() => mockRepository.getCountries()).called(2);
      },
    );
  });
}
