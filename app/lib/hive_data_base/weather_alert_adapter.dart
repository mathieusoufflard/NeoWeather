import 'package:hive/hive.dart';

import '../model/weather_alert.dart';


class WeatherAlertAdapter extends TypeAdapter<WeatherAlert> {
  @override
  final int typeId = 5; // Unique ID for WeatherAlert

  @override
  WeatherAlert read(BinaryReader reader) {
    return WeatherAlert(
      senderName: reader.readString(),
      event: reader.readString(),
      start: reader.readInt(),
      end: reader.readInt(),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherAlert obj) {
    writer.writeString(obj.senderName);
    writer.writeString(obj.event);
    writer.writeInt(obj.start);
    writer.writeInt(obj.end);
    writer.writeString(obj.description);
  }
}
