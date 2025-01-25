import 'package:app/model/weather_condition.dart';

class HourlyWeather {
  final int dt;
  final double temp;
  final WeatherCondition weather;

  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dt: json['dt'],
      temp: (json['temp'] as num).toDouble(),
      weather: WeatherCondition.fromJson(json['weather'][0]),
    );
  }
}