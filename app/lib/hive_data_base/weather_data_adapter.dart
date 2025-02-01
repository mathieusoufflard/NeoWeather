import 'package:hive/hive.dart';
import '../model/daily_weather.dart';
import '../model/hourly_weather.dart';
import '../model/weather_alert.dart';
import '../model/weather_data.dart';
import 'current_weather_adapter.dart';

class WeatherDataAdapter extends TypeAdapter<WeatherData> {
  @override
  final int typeId = 1;

  @override
  WeatherData read(BinaryReader reader) {
    return WeatherData(
      timezone: reader.readString(),
      current: CurrentWeatherAdapter().read(reader),
      hourly: reader.readList().cast<HourlyWeather>(),
      daily: reader.readList().cast<DailyWeather>(),
      alerts: reader.readList().cast<WeatherAlert>(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherData obj) {
    writer.writeString(obj.timezone);
    CurrentWeatherAdapter().write(writer, obj.current);
    writer.writeList(obj.hourly);
    writer.writeList(obj.daily);
    writer.writeList(obj.alerts ?? []);
  }
}
