import 'package:app/ui/pages/city_list.dart';
import 'package:app/ui/widget_utils/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'hive_data_base/city_adapter.dart';
import 'hive_data_base/current_weather_adapter.dart';
import 'hive_data_base/daily_temperature_adapter.dart';
import 'hive_data_base/daily_weather_adapter.dart';
import 'hive_data_base/hourly_weather_adapter.dart';
import 'hive_data_base/weather_alert_adapter.dart';
import 'hive_data_base/weather_condition_adapter.dart';
import 'hive_data_base/weather_data_adapter.dart';
import 'model/city.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init('${appDocumentDir.path}/hive_database');

  Hive.registerAdapter(CityAdapter());
  Hive.registerAdapter(WeatherDataAdapter());
  Hive.registerAdapter(CurrentWeatherAdapter());
  Hive.registerAdapter(WeatherConditionAdapter());
  Hive.registerAdapter(HourlyWeatherAdapter());
  Hive.registerAdapter(DailyWeatherAdapter());
  Hive.registerAdapter(DailyTemperatureAdapter());
  Hive.registerAdapter(WeatherAlertAdapter());

  await Hive.openBox<City>('cities');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GradientScaffold(child: CityList()),
      debugShowCheckedModeBanner: false,
    );
  }
}
