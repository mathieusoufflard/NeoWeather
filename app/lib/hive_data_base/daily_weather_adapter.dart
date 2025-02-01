import 'package:app/hive_data_base/weather_condition_adapter.dart';
import 'package:hive/hive.dart';
import '../model/daily_weather.dart';
import 'daily_temperature_adapter.dart';

class DailyWeatherAdapter extends TypeAdapter<DailyWeather> {
  @override
  final int typeId = 3; // Unique ID for DailyWeather

  @override
  DailyWeather read(BinaryReader reader) {
    return DailyWeather(
      dt: reader.readInt(),
      temp: DailyTemperatureAdapter().read(reader),
      weather: WeatherConditionAdapter().read(reader),
    );
  }

  @override
  void write(BinaryWriter writer, DailyWeather obj) {
    writer.writeInt(obj.dt);
    DailyTemperatureAdapter().write(writer, obj.temp);
    WeatherConditionAdapter().write(writer, obj.weather);
  }
}
