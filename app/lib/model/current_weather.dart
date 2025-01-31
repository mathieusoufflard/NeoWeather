import 'package:app/model/weather_condition.dart';

/// Represents the current weather conditions at a specific location.
///
/// This class provides detailed weather information, including temperature,
/// humidity, wind speed, and other atmospheric conditions.
class CurrentWeather {
  /// Unix timestamp (UTC) representing the current time.
  final int dt;

  /// Unix timestamp (UTC) of the sunrise time.
  final int sunrise;

  /// Unix timestamp (UTC) of the sunset time.
  final int sunset;

  /// Current temperature in degrees Celsius.
  final double temp;

  /// Feels-like temperature in degrees Celsius.
  final double feelsLike;

  /// Atmospheric pressure in hPa (hectopascals).
  final int pressure;

  /// Humidity percentage (0-100).
  final int humidity;

  /// UV index (UVI), representing the level of ultraviolet radiation.
  final double uvi;

  /// Visibility in meters.
  final int visibility;

  /// Wind speed in meters per second (m/s).
  final double windSpeed;

  /// Weather condition details (e.g., description, icon, ID).
  final WeatherCondition weather;

  /// Creates an instance of [CurrentWeather].
  ///
  /// - [dt] : The current timestamp.
  /// - [sunrise] : The sunrise timestamp.
  /// - [sunset] : The sunset timestamp.
  /// - [temp] : The current temperature.
  /// - [feelsLike] : The feels-like temperature.
  /// - [pressure] : The atmospheric pressure.
  /// - [humidity] : The humidity percentage.
  /// - [uvi] : The UV index.
  /// - [visibility] : The visibility in meters.
  /// - [windSpeed] : The wind speed in meters per second.
  /// - [weather] : The weather condition object.
  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.uvi,
    required this.visibility,
    required this.windSpeed,
    required this.weather,
  });

  /// Factory constructor that creates a [CurrentWeather] instance from a JSON object.
  ///
  /// - [json] : A JSON map containing weather data.
  /// - Returns a [CurrentWeather] instance.
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      uvi: (json['uvi'] as num).toDouble(),
      visibility: json['visibility'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      weather: WeatherCondition.fromJson(json['weather'][0]),
    );
  }
}
