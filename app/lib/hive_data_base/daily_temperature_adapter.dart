import 'package:hive/hive.dart';
import '../model/daily_temperature.dart';

class DailyTemperatureAdapter extends TypeAdapter<DailyTemperature> {
  @override
  final int typeId = 7; // Unique ID for DailyTemperature

  @override
  DailyTemperature read(BinaryReader reader) {
    return DailyTemperature(
      min: reader.readDouble(),
      max: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyTemperature obj) {
    writer.writeDouble(obj.min);
    writer.writeDouble(obj.max);
  }
}
