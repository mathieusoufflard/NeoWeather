import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/weather_data.dart';

void main() {
  group('WeatherData Tests', () {
    test('WeatherData.fromJson creates an instance from JSON', () {
      const jsonString = '''{
        "timezone": "Europe/Paris",
        "current": {
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
        },
        "hourly": [
          {
            "dt": 1617182400,
            "temp": 15.5,
            "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
          }
        ],
        "daily": [
          {
            "dt": 1617182400,
            "temp": {"min": 14.0, "max": 16.0},
            "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
          }
        ],
        "alerts": [
          {
            "sender_name": "Weather Org",
            "event": "Storm Warning",
            "start": 1617182400,
            "end": 1617192400,
            "description": "Severe storm expected"
          }
        ]
      }''';

      final Map<String, dynamic> json = jsonDecode(jsonString);

      final weatherData = WeatherData.fromJson(json);

      // Test current weather
      expect(weatherData.timezone, 'Europe/Paris');
      expect(weatherData.current.temp, 15.5);
      expect(weatherData.current.weather.id, 800);

      // Test hourly weather
      expect(weatherData.hourly[0].temp, 15.5);
      expect(weatherData.hourly[0].weather.id, 800);

      // Test daily weather
      expect(weatherData.daily[0].temp.min, 14.0);
      expect(weatherData.daily[0].weather.id, 800);

      // Test alerts
      expect(weatherData.alerts![0].event, 'Storm Warning');
      expect(weatherData.alerts![0].description, 'Severe storm expected');
    });
  });
}
