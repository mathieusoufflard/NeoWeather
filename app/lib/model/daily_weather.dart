import 'package:app/model/weather_condition.dart';
import 'daily_temperature.dart';

/// Represents the weather forecast for a single day.
///
/// This class includes the date (timestamp), temperature range, and weather conditions.
class DailyWeather {
  /// Unix timestamp (UTC) representing the date of the forecast.
  final int dt;

  /// The temperature range (min and max) for the day.
  final DailyTemperature temp;

  /// The primary weather condition (e.g., Clear, Rain, Snow).
  final WeatherCondition weather;

  /// Creates an instance of [DailyWeather].
  ///
  /// - [dt]: The Unix timestamp representing the forecast date.
  /// - [temp]: The temperature range for the day.
  /// - [weather]: The main weather condition for the day.
  DailyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  /// Factory constructor that creates a [DailyWeather] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing daily weather data.
  /// - Returns a [DailyWeather] instance.
  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'],
      temp: DailyTemperature.fromJson(json['temp']),
      weather: WeatherCondition.fromJson(json['weather'][0]),
    );
  }
}
