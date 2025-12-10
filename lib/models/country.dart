class Country {
  final String id;
  final String name;
  final String flag;

  Country({
    required this.id,
    required this.name,
    required this.flag,
  });

  factory Country.fromMap({required Map map}) {
    return Country(
      id: map['code'],
      name: map['name'],
      flag: map['emoji'],
    );
  }
}
