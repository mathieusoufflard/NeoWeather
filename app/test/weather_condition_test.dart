import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/weather_condition.dart';

void main() {
  group('WeatherCondition Tests', () {
    test('WeatherCondition.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "id": 800,
        "main": "Clear",
        "description": "clear sky"
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final weatherCondition = WeatherCondition.fromJson(json);

      expect(weatherCondition.id, 800);
      expect(weatherCondition.main, 'Clear');
      expect(weatherCondition.description, 'clear sky');
    });
  });
}
