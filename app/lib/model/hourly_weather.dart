import 'package:app/model/weather_condition.dart';

/// Represents the weather forecast for a specific hour.
///
/// This class includes the timestamp, temperature, and weather condition for an hourly forecast.
class HourlyWeather {
  /// Unix timestamp (UTC) representing the forecasted hour.
  final int dt;

  /// Temperature at the given hour (in Celsius by default).
  final double temp;

  /// The primary weather condition (e.g., Clear, Rain, Snow).
  final WeatherCondition weather;

  /// Creates an instance of [HourlyWeather].
  ///
  /// - [dt]: The Unix timestamp representing the forecast hour.
  /// - [temp]: The temperature at that hour.
  /// - [weather]: The weather condition at that hour.
  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  /// Factory constructor that creates an [HourlyWeather] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing hourly weather data.
  /// - Returns an [HourlyWeather] instance.
  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dt: json['dt'],
      temp: (json['temp'] as num).toDouble(),
      weather: WeatherCondition.fromJson(json['weather'][0]),
    );
  }
}
