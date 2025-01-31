import 'package:app/model/city.dart';
import 'package:app/model/weather_data.dart';
import 'package:app/ui/pages/add_city.dart';
import 'package:app/ui/pages/weather_details.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:app/utils/api_call.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

/// Represents the list of cities in the application.
///
/// This class handles the display of a list of cities, fetches weather data for
/// each city, and provides navigation to detailed weather information for each city.
class CityList extends StatefulWidget {

  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {

  /// List of cities stored in the app.
  ///
  /// This list holds the cities added by the user, along with their weather data.
  late List<City> _cities = [];

  /// Initializes the state and fetches weather data for all cities.
  ///
  /// This method is called once when the widget is initialized. It checks if there
  /// are any cities in the list, and if so, fetches weather data for each city.
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

  /// Fetches the weather data for a city based on its coordinates.
  ///
  /// - [lat] : Latitude of the city.
  /// - [lon] : Longitude of the city.
  /// - [element] : The city object for which to fetch weather data.
  ///
  /// This method makes an API call to fetch weather data for a specific city and updates
  /// the city object with the new weather data. It then updates the UI with the new data.
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
      print('Erreur: $e');
    }
  }

  /// Builds the widget tree for the CityList screen.
  ///
  /// This method returns the layout for the CityList screen, which includes
  /// the title, the list of cities, and the button to add a new city.
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

  /// Returns the title widget for the CityList screen.
  ///
  /// This widget is displayed at the top of the screen with the text 'NeoWeather'.
  title() => const Align(
    alignment: Alignment.topCenter,
    child: Text(
      'NeoWeather',
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  /// Returns the list widget showing all cities and their weather data.
  ///
  /// This widget shows the cities in a list format. If there are no cities added,
  /// a message indicating no cities are added is displayed. Each city item can be tapped
  /// to navigate to a detailed weather screen for that city.
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
                              ? '${_cities[index].weatherData!.current.temp.round()}°'
                              : "--°",
                              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
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

  /// Returns the button widget for adding a new city.
  ///
  /// This widget displays a floating action button that, when pressed, opens
  /// the AddCity page. When a new city is added, the weather data for that city
  /// is fetched and the city is added to the list.
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
      ),
    ),
  );
}
