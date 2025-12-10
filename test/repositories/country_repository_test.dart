import 'package:advanced_task_manager/data/repositories/countries/country_repository.dart';
import 'package:advanced_task_manager/models/country.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

// -----------------------------------------------------------------------------
// MOCKS
// -----------------------------------------------------------------------------
class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockQueryResult extends Mock implements QueryResult {}

void main() {
  late MockGraphQLClient mockClient;
  late CountryRepository repository;

  setUp(() {
    mockClient = MockGraphQLClient();
    repository = CountryRepository(mockClient);
  });

  group('CountryRepository.getCountries', () {
    test('retorna lista de países cuando la respuesta es correcta', () async {
      // Arrange
      final mockResult = MockQueryResult();

      when(() => mockResult.hasException).thenReturn(false);
      when(() => mockResult.data).thenReturn({
        'countries': [
          {'code': 'CO', 'name': 'Colombia', 'emoji': '🇨🇴'},
          {'code': 'PE', 'name': 'Perú', 'emoji': '🇵🇪'},
        ],
      });

      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      final result = await repository.getCountries();

      // Assert
      expect(result, isA<List<Country>>());
      expect(result.length, 2);
      expect(result.first.name, 'Colombia');
      expect(result.first.flag, '🇨🇴');
    });

    test('lanza excepción cuando hay un error en el servidor GraphQL', () async {
      // Arrange
      final mockResult = MockQueryResult();

      when(() => mockResult.hasException).thenReturn(true);
      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      final call = repository.getCountries;

      // Assert
      expect(
        () async => await call(),
        throwsA(isA<Exception>()),
      );
    });

    test('lanza excepción cuando data es null', () async {
      // Arrange
      final mockResult = MockQueryResult();

      when(() => mockResult.hasException).thenReturn(false);
      when(() => mockResult.data).thenReturn(null);

      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      final call = repository.getCountries;

      // Assert
      expect(() async => await call(), throwsA(isA<Exception>()));
    });

    test('lanza excepción cuando "countries" es null', () async {
      // Arrange
      final mockResult = MockQueryResult();

      when(() => mockResult.hasException).thenReturn(false);
      when(() => mockResult.data).thenReturn({
        'countries': null,
      });

      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      final call = repository.getCountries;

      // Assert
      expect(() async => await call(), throwsA(isA<Exception>()));
    });

    test('lanza excepción ante un error inesperado (map inválido)', () async {
      // Arrange
      final mockResult = MockQueryResult();

      when(() => mockResult.hasException).thenReturn(false);
      when(() => mockResult.data).thenReturn({
        'countries': ['valor_invalido'],
      });

      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      final call = repository.getCountries;

      // Assert
      expect(() async => await call(), throwsA(isA<Exception>()));
    });
  });
}
