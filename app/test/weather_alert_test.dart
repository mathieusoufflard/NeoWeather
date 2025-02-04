import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/weather_alert.dart';

void main() {
  group('WeatherAlert Tests', () {
    test('WeatherAlert.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "sender_name": "Weather Org",
        "event": "Storm Warning",
        "start": 1617182400,
        "end": 1617192400,
        "description": "Severe storm expected"
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final weatherAlert = WeatherAlert.fromJson(json);

      expect(weatherAlert.senderName, 'Weather Org');
      expect(weatherAlert.event, 'Storm Warning');
      expect(weatherAlert.description, 'Severe storm expected');
    });
  });
}
