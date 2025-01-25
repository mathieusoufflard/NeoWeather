class City {
  final String name;
  final double lat;
  final double lon;
  final String? state;
  final String country;

  City({
    required this.name,
    required this.lat,
    required this.lon,
    this.state,
    required this.country,
  });

  List<City> parseCities(List<dynamic> jsonList) {
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      state: json['state'],
      country: json['country'],
    );
  }
}