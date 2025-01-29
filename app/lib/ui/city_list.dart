import 'package:app/model/city.dart';
import 'package:app/model/weather_data.dart';
import 'package:app/ui/add_city.dart';
import 'package:app/ui/weather_details.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:app/utils/api_call.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class CityList extends StatefulWidget{

  const CityList({super.key,});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList>{

  late List<City> _cities = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_cities.isNotEmpty) {
        for (var city in _cities) {
          _fetchCityWeather(city.lat, city.lon, city);
        }
      }
    });
  }

  Future<void> _fetchCityWeather(double lat, double lon, City element) async {
    try {
      final WeatherData weatherData = await ApiCall.getWeatherData(lat, lon);
      int index = _cities.indexWhere((city) => city.name == element.name);
      if (index != -1) {
        _cities[index] = City(
          name: element.name,
          lat: element.lat,
          lon: element.lon,
          country: element.country,
          weatherData: weatherData,
        );
      }
      setState(() {
        _cities = List.from(_cities);
      });
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
  return Stack(
    children: [
      title(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          list(),
          addBtn(),
        ],
      ),
    ],
  );


  }

  title() => const Align(
    alignment: Alignment.topCenter,child: Text(
    'NeoWeather',
    style: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
  ),
  );

  list() {
    if (_cities.isEmpty) {
      return const Center(child: Text("Aucune ville ajoutée", style: TextStyle(color: Colors.white, fontSize: 16)));
    } else {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 450.0),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _cities.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherDetails(_cities[index])));
                },
                child: Container(
                  height: 90,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            _cities[index].weatherData != null
                                ? Utils.getWeatherIcon((_cities[index].weatherData!.current.weather.id))
                                : 'assets/navigation/loading.png',
                            scale: 1.5,
                            color: Colors.black,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppWidgets.customText(text: _cities[index].name, color: Colors.black, fontWeight: FontWeight.bold),
                              AppWidgets.customText(
                                  text: _cities[index].weatherData != null
                                      ? _cities[index].weatherData!.current.weather.main
                                      : "Chargement...",
                                  color: Colors.black),
                            ],
                          ),
                          AppWidgets.customText(text: _cities[index].weatherData != null
                              ? '${_cities[index].weatherData!.current.temp}°'
                              : "--°",
                              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                          //Text('test°'),
                        ]
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  addBtn() => Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 40,
        right: 40,
      ),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()))
              .then((newCity) {
            if (newCity != null) {
              setState(() {
                _cities = List.from(_cities)..add(newCity);
              });
              _fetchCityWeather(newCity.lat, newCity.lon, newCity).then((_) {
                setState(() {});
              });
            }
          });
        },
        backgroundColor: Colors.white,
        child: const Text(
          '+',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      )
    ),
  );
}