import 'package:app/model/weather_alert.dart';
import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';

/// Represents comprehensive weather data for a specific location.
///
/// This class encapsulates current weather conditions, hourly and daily forecasts,
/// weather alerts, and timezone information.
class WeatherData {
  /// The timezone of the location (e.g., "Europe/Paris").
  final String timezone;

  /// The current weather conditions.
  final CurrentWeather current;

  /// The list of hourly weather forecasts.
  final List<HourlyWeather> hourly;

  /// The list of daily weather forecasts.
  final List<DailyWeather> daily;

  /// Optional list of weather alerts (if available).
  final List<WeatherAlert>? alerts;

  /// Creates a [WeatherData] instance.
  ///
  /// - [timezone]: The timezone of the location.
  /// - [current]: The current weather conditions.
  /// - [hourly]: A list of hourly weather forecasts.
  /// - [daily]: A list of daily weather forecasts.
  /// - [alerts]: A list of weather alerts (nullable).
  WeatherData({
    required this.timezone,
    required this.current,
    required this.hourly,
    required this.daily,
    this.alerts,
  });

  /// Factory constructor that creates a [WeatherData] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing weather data.
  /// - Returns a [WeatherData] instance.
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
