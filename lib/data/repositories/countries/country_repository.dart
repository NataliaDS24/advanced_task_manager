import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/data/api_helper/api_const.dart';
import 'package:advanced_task_manager/models/country.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryRepository {
  final GraphQLClient client;

  CountryRepository(this.client);

  Future<List<Country>> getCountries() async {
    try {
      const query = ApiConst.queryCountries;

      final options = QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await client.query(options);

      if (result.hasException) {
        throw Exception(AppStrings.errorCountryQuery);
      }

      final data = result.data;
      if (data == null || data['countries'] == null) {
        throw Exception(AppStrings.errorCountryApiEmpty);
      }

      final rawList = data['countries'] as List<dynamic>;
      return rawList
          .map((e) => Country.fromMap(map: e))
          .toList();

    } catch (e) {
      throw Exception(AppStrings.errorCountriesRetrieved);
    }
  }
}