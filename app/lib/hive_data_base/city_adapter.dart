import 'package:app/hive_data_base/weather_data_adapter.dart';
import 'package:hive/hive.dart';
import '../model/city.dart';
import '../model/weather_data.dart';


class CityAdapter extends TypeAdapter<City> {
  @override
  final int typeId = 0;

  @override
  City read(BinaryReader reader) {
    return City(
      name: reader.readString(),
      lat: reader.readDouble(),
      lon: reader.readDouble(),
      state: reader.readString(),
      country: reader.readString(),
      weatherData: reader.read() as WeatherData?,
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.lat);
    writer.writeDouble(obj.lon);
    writer.writeString(obj.state ?? "");
    writer.writeString(obj.country);
    writer.write(obj.weatherData);
  }
}
