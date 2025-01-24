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
}