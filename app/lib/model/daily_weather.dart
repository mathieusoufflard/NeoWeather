import 'package:app/model/weather_condition.dart';
import 'daily_temperature.dart';

class DailyWeather {
  final int dt;
  final DailyTemperature temp;
  final WeatherCondition weather;

  DailyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'],
      temp: DailyTemperature.fromJson(json['temp']),
      weather: WeatherCondition.fromJson(json['weather'][0]),
    );
  }
}