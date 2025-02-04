import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/hourly_weather.dart';

void main() {
  group('HourlyWeather Tests', () {
    test('HourlyWeather.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "dt": 1617182400,
        "temp": 15.5,
        "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final hourlyWeather = HourlyWeather.fromJson(json);

      expect(hourlyWeather.dt, 1617182400);
      expect(hourlyWeather.temp, 15.5);
      expect(hourlyWeather.weather.id, 800);
    });
  });
}
