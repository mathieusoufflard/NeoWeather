import 'package:app/hive_data_base/weather_condition_adapter.dart';
import 'package:hive/hive.dart';
import '../model/hourly_weather.dart';

class HourlyWeatherAdapter extends TypeAdapter<HourlyWeather> {
  @override
  final int typeId = 4; // Unique ID for HourlyWeather

  @override
  HourlyWeather read(BinaryReader reader) {
    return HourlyWeather(
      dt: reader.readInt(),
      temp: reader.readDouble(),
      weather: WeatherConditionAdapter().read(reader),
    );
  }

  @override
  void write(BinaryWriter writer, HourlyWeather obj) {
    writer.writeInt(obj.dt);
    writer.writeDouble(obj.temp);
    WeatherConditionAdapter().write(writer, obj.weather);
  }
}
