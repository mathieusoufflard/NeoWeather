import 'package:hive/hive.dart';
import '../model/weather_condition.dart';


class WeatherConditionAdapter extends TypeAdapter<WeatherCondition> {
  @override
  final int typeId = 6; // Unique ID for WeatherCondition

  @override
  WeatherCondition read(BinaryReader reader) {
    return WeatherCondition(
      id: reader.readInt(),
      main: reader.readString(),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherCondition obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.main);
    writer.writeString(obj.description);
  }
}
