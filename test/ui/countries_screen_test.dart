import 'package:advanced_task_manager/models/country.dart';
import 'package:advanced_task_manager/data/repositories/countries/country_repository.dart';
import 'package:advanced_task_manager/ui/screens/countries/countries_notifier.dart';
import 'package:advanced_task_manager/ui/screens/countries/countries_screen.dart';
import 'package:advanced_task_manager/ui/screens/countries/countries_notifier_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

/// Mock del repositorio
class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late MockCountryRepository mockRepository;

  final mockList = [
    Country(id: 'CO', name: 'Colombia', flag: '🇨🇴'),
    Country(id: 'MX', name: 'México', flag: '🇲🇽'),
  ];

  setUp(() {
    mockRepository = MockCountryRepository();
  });

  /// Helper para construir el widget con provider override
  Widget buildWidget() {
    return ProviderScope(
      overrides: [
        countriesNotifierProvider.overrideWith(
          (ref) => CountriesNotifier(mockRepository),
        ),
      ],
      child: const MaterialApp(
        home: CountriesScreen(),
      ),
    );
  }

  group('CountriesScreen UI tests', () {
    testWidgets('Debe mostrar loading mientras carga', (tester) async {
      // El future nunca concluye en este pump inicial
      when(() => mockRepository.getCountries())
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 1), () => mockList));

      await tester.pumpWidget(buildWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Debe mostrar lista de países al cargar correctamente', (tester) async {
      when(() => mockRepository.getCountries())
          .thenAnswer((_) async => mockList);

      await tester.pumpWidget(buildWidget());

      // Permite ejecutar loadCountries()
      await tester.pumpAndSettle();

      expect(find.text('Colombia'), findsOneWidget);
      expect(find.text('México'), findsOneWidget);

      expect(find.text('🇨🇴'), findsOneWidget);
      expect(find.text('🇲🇽'), findsOneWidget);

      // Verifica que las Cards están presentes
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('Debe mostrar mensaje de error y botón Retry cuando la API falla', (tester) async {
      when(() => mockRepository.getCountries())
          .thenThrow(Exception('Error test'));

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('Error'), findsOneWidget);   
      expect(find.text('Reintentar'), findsOneWidget); // Ajusta si tu string difiere
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('El botón Retry debe llamar nuevamente a loadCountries', (tester) async {
      // Primer llamado: falla
      when(() => mockRepository.getCountries())
          .thenThrow(Exception('Error test'));

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      // Verifica el error inicial
      expect(find.textContaining('Error'), findsOneWidget);

      // Segundo llamado: éxito
      when(() => mockRepository.getCountries())
          .thenAnswer((_) async => mockList);

      // Presiona Retry
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Ahora la UI debería mostrar los países
      expect(find.text('Colombia'), findsOneWidget);
      expect(find.text('México'), findsOneWidget);
    });
  });
}
