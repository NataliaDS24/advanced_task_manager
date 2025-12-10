class ApiConst {
  static const String all = '/todos';
  static const String queryCountries = r'''
        query {
          countries {
            code
            name
            emoji
          }
        }
      ''';
}
