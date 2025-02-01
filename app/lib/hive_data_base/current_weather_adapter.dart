import 'package:app/hive_data_base/weather_condition_adapter.dart';
import 'package:hive/hive.dart';
import '../model/current_weather.dart';

class CurrentWeatherAdapter extends TypeAdapter<CurrentWeather> {
  @override
  final int typeId = 2; // Unique ID for CurrentWeather

  @override
  CurrentWeather read(BinaryReader reader) {
    return CurrentWeather(
      dt: reader.readInt(),
      sunrise: reader.readInt(),
      sunset: reader.readInt(),
      temp: reader.readDouble(),
      feelsLike: reader.readDouble(),
      pressure: reader.readInt(),
      humidity: reader.readInt(),
      uvi: reader.readDouble(),
      visibility: reader.readInt(),
      windSpeed: reader.readDouble(),
      weather: WeatherConditionAdapter().read(reader),
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeather obj) {
    writer.writeInt(obj.dt);
    writer.writeInt(obj.sunrise);
    writer.writeInt(obj.sunset);
    writer.writeDouble(obj.temp);
    writer.writeDouble(obj.feelsLike);
    writer.writeInt(obj.pressure);
    writer.writeInt(obj.humidity);
    writer.writeDouble(obj.uvi);
    writer.writeInt(obj.visibility);
    writer.writeDouble(obj.windSpeed);
    WeatherConditionAdapter().write(writer, obj.weather);
  }
}
