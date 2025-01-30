import 'package:app/model/weather_alert.dart';
import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherData {
  String timezone;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final List<WeatherAlert>? alerts;

  WeatherData({
    required this.timezone,
    required this.current,
    required this.hourly,
    required this.daily,
    this.alerts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      timezone: json['timezone'],
      current: CurrentWeather.fromJson(json['current']),
      hourly: (json['hourly'] as List<dynamic>)
          .map((hour) => HourlyWeather.fromJson(hour))
          .toList(),
      daily: (json['daily'] as List<dynamic>)
          .map((day) => DailyWeather.fromJson(day))
          .toList(),
      alerts: json['alerts'] != null
          ? (json['alerts'] as List<dynamic>)
          .map((alert) => WeatherAlert.fromJson(alert))
          .toList()
          : null,
    );
  }
}