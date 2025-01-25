import 'package:app/model/weather_condition.dart';

class CurrentWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double uvi;
  final int visibility;
  final double windSpeed;
  final WeatherCondition weather;

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