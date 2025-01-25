import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/city.dart';
import 'package:http/http.dart' as http;

import '../model/weather_data.dart';

class ApiCall{
  static const String _geoBaseUrl = 'http://api.openweathermap.org/geo/1.0/direct';
  static const String _weatherBaseUrl = 'https://api.openweathermap.org/data/3.0/onecall';

  static Future<List<City>> getCityCoordinates(String cityName, {int limit = 5}) async {
    final url = Uri.parse("$_geoBaseUrl?q=$cityName&limit=$limit&appid=${dotenv.env['API_KEY']}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors de la récupération des coordonnées : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'appel API : $e');
    }
  }

  static Future<WeatherData> getWeatherData(double lat, double lon, {String unit = 'metric', String lang = 'fr', String exclude = 'minutely',}) async {
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
}