class Country {
  int id;
  String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromMap({required Map map}) {
    return Country(
      id: map['id'],
      name: map['name'],
    );
  }
}
