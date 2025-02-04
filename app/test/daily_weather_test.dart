import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/daily_weather.dart';

void main() {
  group('DailyWeather Tests', () {
    test('DailyWeather.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "dt": 1617182400,
        "temp": {"min": 14.0, "max": 16.0},
        "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final dailyWeather = DailyWeather.fromJson(json);

      expect(dailyWeather.dt, 1617182400);
      expect(dailyWeather.temp.min, 14.0);
      expect(dailyWeather.weather.id, 800);
    });
  });
}
