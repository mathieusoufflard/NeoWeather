import 'package:app/model/weather_data.dart';

/// Represents a city with geographical coordinates and weather data.
///
/// This class contains essential information about a city, including its name,
/// latitude, longitude, optional state, and country. It also holds weather data
/// if available.
class City {
  /// The name of the city.
  final String name;

  /// The latitude coordinate of the city.
  final double lat;

  /// The longitude coordinate of the city.
  final double lon;

  /// The state or region where the city is located (optional).
  final String? state;

  /// The country where the city is located.
  final String country;

  /// The weather data associated with the city (nullable).
  WeatherData? weatherData;

  /// Creates an instance of [City].
  ///
  /// - [name] : The city's name.
  /// - [lat] : The latitude coordinate.
  /// - [lon] : The longitude coordinate.
  /// - [state] : The optional state or region.
  /// - [country] : The country name.
  /// - [weatherData] : The optional weather data for the city.
  City({
    required this.name,
    required this.lat,
    required this.lon,
    this.state,
    required this.country,
    this.weatherData,
  });

  /// Parses a list of JSON objects into a list of [City] instances.
  ///
  /// - [jsonList] : A list of JSON objects representing cities.
  /// - Returns a list of [City] objects.
  List<City> parseCities(List<dynamic> jsonList) {
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  /// Factory constructor that creates a [City] instance from a JSON object.
  ///
  /// - [json] : A JSON map containing city data.
  /// - Returns a [City] instance.
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
