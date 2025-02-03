import 'dart:convert';
import 'package:app/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import '../model/city.dart';
import 'package:http/http.dart' as http;

import '../model/weather_data.dart';

/// Class for making API calls related to weather.
///
/// This class provides methods to get the coordinates of a city
/// and its associated weather data using the OpenWeather API.
class ApiCall {
  static const String _geoBaseUrl = 'http://api.openweathermap.org/geo/1.0/direct';
  static const String _geoBaseUrlRevers = "http://api.openweathermap.org/geo/1.0/reverse";
  static const String _weatherBaseUrl = 'https://api.openweathermap.org/data/3.0/onecall';

  /// Retrieves the coordinates of a city using the OpenWeather API.
  ///
  /// - [cityName] : The name of the city to search for.
  /// - [limit] : The number of results to return (default is 5).
  /// Returns a list of [City] objects representing the found cities.
  static Future<List<City>> getCityCoordinates(String cityName, {int limit = 5}) async {
    final url = Uri.parse("$_geoBaseUrl?q=$cityName&limit=$limit&appid=${dotenv.env['API_KEY']}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors de la récupération des coordonnées :${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'appel API : $e');
    }
  }

  /// Retrieves weather data for a specific location.
  ///
  /// - [lat] : The latitude of the location.
  /// - [lon] : The longitude of the location.
  /// - [unit] : The unit of temperature (default is 'metric' for Celsius).
  /// - [lang] : The language of the returned data (default is 'fr' for French).
  /// - [exclude] : Data to exclude from the response (default is 'minutely').
  /// Returns a [WeatherData] object containing the weather information.
  static Future<WeatherData> getWeatherData(double lat, double lon, {String unit = 'metric', String lang = 'fr', String exclude = 'minutely'}) async {
    final url = Uri.parse(
        "$_weatherBaseUrl?lat=$lat&lon=$lon&units=$unit&lang=$lang&exclude=$exclude&appid=${dotenv.env['API_KEY']}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return WeatherData.fromJson(jsonResponse);
      } else {
        throw Exception('Erreur lors de la récupération des données météo : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'appel API météo : $e');
    }
  }

  /// Retrieves the city name, state, and country from latitude and longitude using OpenWeather's reverse geocoding API.
  ///
  /// - [lat] : Latitude of the location.
  /// - [lon] : Longitude of the location.
  /// Returns a [City] object with the retrieved information.
  static Future<City?> getCityFromCoordinates(double lat, double lon, {int limit = 1}) async {
    final url = Uri.parse(
        "$_geoBaseUrlRevers?lat=$lat&lon=$lon&limit=$limit&appid=${dotenv.env['API_KEY']}");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.isNotEmpty) {
          final cityData = jsonResponse.first;
          return City(
            name: cityData['name'],
            lat: lat,
            lon: lon,
            state: cityData['state'],
            country: cityData['country'],
          );
        }
      } else {
        throw Exception('Erreur lors de la récupération de la ville : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'appel API de reverse geocoding : $e');
    }
  }
}