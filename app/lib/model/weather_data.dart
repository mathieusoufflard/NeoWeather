import 'package:app/model/weather_alert.dart';
import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherData {
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final List<WeatherAlert>? alerts;

  WeatherData({
    required this.current,
    required this.hourly,
    required this.daily,
    this.alerts,
  });
}