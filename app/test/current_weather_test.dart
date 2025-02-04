import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/current_weather.dart';

void main() {
  group('CurrentWeather Tests', () {
    test('CurrentWeather.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "dt": 1617182400,
        "sunrise": 1617160800,
        "sunset": 1617211200,
        "temp": 15.5,
        "feels_like": 14.3,
        "pressure": 1013,
        "humidity": 60,
        "uvi": 3.1,
        "visibility": 10000,
        "wind_speed": 5.5,
        "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final currentWeather = CurrentWeather.fromJson(json);

      expect(currentWeather.dt, 1617182400);
      expect(currentWeather.temp, 15.5);
      expect(currentWeather.weather.id, 800);
    });
  });
}
