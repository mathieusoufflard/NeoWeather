class City {
  final String name;
  final double lat;
  final double lon;
  final String? state; // Facultatif, car certaines entrées peuvent ne pas contenir cet attribut.
  final String country;

  City({
    required this.name,
    required this.lat,
    required this.lon,
    this.state,
    required this.country,
  });
}