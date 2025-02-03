import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../model/city.dart';
import 'package:geolocator/geolocator.dart';

import '../model/weather_data.dart';
import '../ui/widget_utils/app_widgets.dart';
import 'api_call.dart';

/// A utility class that provides helper methods for working with weather data and time zones.
///
/// This class includes methods to:
/// - Get the corresponding weather icon based on weather condition IDs.
/// - Convert timestamps to different time formats (hour, hour-minute, day of the week).
/// - Convert English weekdays to French.
class Utils {

  Utils._();

  /// Returns the weather icon corresponding to the given weather ID.
  ///
  /// - [weatherId] : The weather condition ID, which corresponds to different weather types.
  /// Returns the path to the weather icon based on the weather ID.
  static String getWeatherIcon(int weatherId) {
    switch (weatherId) {
    // 🌩️ Thunderstorm
      case 200:
      case 201:
      case 202:
      case 210:
      case 211:
      case 212:
      case 221:
      case 230:
      case 231:
      case 232:
        return 'assets/weather_icon/thunderstorm.png';

    // 🌧️ Drizzle
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return 'assets/weather_icon/rain.png';

    // 🌧️ Rain
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 511:
      case 520:
      case 521:
      case 522:
      case 531:
        return 'assets/weather_icon/shower_rain.png';

    // ❄️ Snow
      case 600:
      case 601:
      case 602:
      case 611:
      case 612:
      case 613:
      case 615:
      case 616:
      case 620:
      case 621:
      case 622:
        return 'assets/weather_icon/snow.png';

    // 🌫️ Mist
      case 701:
      case 711:
      case 721:
      case 731:
      case 741:
      case 751:
      case 761:
      case 762:
      case 771:
      case 781:
        return 'assets/weather_icon/mist.png';

    // ☀️ Clear sky
      case 800:
        return 'assets/weather_icon/clear_sky.png';

    // ⛅ Few clouds
      case 801:
        return 'assets/weather_icon/few_clouds.png';

    // ⛅ Scattered clouds
      case 802:
        return 'assets/weather_icon/scattered_clouds.png';

    // ⛅ Broken clouds
      case 803:
      case 804:
        return 'assets/weather_icon/broken_clouds.png';

    // 🌍 Default in case the ID doesn't match
      default:
        return 'assets/weather_icon/clear_sky.png';
    }
  }

  /// Removes duplicate cities from the list, keeping only one instance per unique state-country pair.
  /// If a city does not have a state, it is assigned "Unknown" to ensure proper uniqueness checks.
  ///
  /// - [cities] : list of city given by the searchBar research.
  /// Returns a list of city without duplication.
  static List<City> removeDuplicateCity(List<City> cities) {
    Set<String> uniqueLocations = {};
    List<City> filteredCities = cities.where((city) {

      final key = "${city.state ?? "Unknown"}-${city.country}";

      if (uniqueLocations.contains(key)) {
        return false;
      } else {
        uniqueLocations.add(key);
        return true;
      }
    }).toList();

    return filteredCities;
  }

  /// Removes duplicate cities from the list toAddCities, keeping only if the city is not on addedCities list.
  /// If a city does not have a state, it is assigned "Unknown" to ensure proper uniqueness checks.
  ///
  /// - [toAddCities] : list of city given by the searchBar research.
  /// - [addedCities] : list of city already added by the user.
  /// Returns a list of city without city already added by the user.
  static List<City> removeAlreadyNowCites(List<City> toAddCities, List<City> addedCities){
    Set<String> existingCities = addedCities.map((city) => "${city.name}-${city.state ?? "Unknown"}-${city.country}").toSet();

    return toAddCities.where((city) {
      final key = "${city.name}-${city.state ?? "Unknown"}-${city.country}";
      return !existingCities.contains(key);
    }).toList();
  }


  /// Converts a given timestamp to the hour in the specified timezone.
  ///
  /// - [dt] : The timestamp to convert.
  /// - [timeZone] : The timezone to use for the conversion.
  /// Returns the hour as a string in the specified timezone.
  static String dtToHour(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);

    return DateFormat('HH').format(localTime);
  }

  /// Converts a given timestamp to the hour and minute in the specified timezone.
  ///
  /// - [dt] : The timestamp to convert.
  /// - [timeZone] : The timezone to use for the conversion.
  /// Returns the hour and minute as a string in the specified timezone.
  static String dtToHourMinute(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);

    return DateFormat('HH:mm').format(localTime);
  }

  /// Converts a given timestamp to the day of the week in the specified timezone.
  ///
  /// - [dt] : The timestamp to convert.
  /// - [timeZone] : The timezone to use for the conversion.
  /// Returns the day of the week as a string in French.
  static String dtDay(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);
    return usDayToFrDay(DateFormat('EEEE', 'en_US').format(localTime));
  }

  /// check if a given timestamp have delay on his local date time.
  ///
  /// - [dt] : The timestamp.
  /// - [timeZone] : The local timezone.
  /// Returns true if the timestamp have delay.
  static bool isLocalDtHaveDelay(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final savedTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);
    final localTime = tz.TZDateTime.now(location);

    return localTime.difference(savedTime).inHours >= 1;
  }

  /// Converts a day of the week in English to French.
  ///
  /// - [format] : The day of the week in English.
  /// Returns the day of the week in French.
  static String usDayToFrDay(String format) {
    switch (format) {
      case 'Monday':
        return 'Lundi';

      case 'Tuesday':
        return 'Mardi';

      case 'Wednesday':
        return 'Mercredi';

      case 'Thursday':
        return 'Jeudi';

      case 'Friday':
        return 'Vendredi';

      case 'Saturday':
        return 'Samedi';

      default:
        return 'Dimanche';
    }
  }

  /// Adds the user's current location as a city in the Hive database.
  ///
  /// This function retrieves the user's current GPS coordinates, converts them into a city name,
  /// fetches the weather data for that city, and saves the city with its weather data in Hive.
  /// If the city is already present in the database, it will not be added.
  static Future<void> addCurrentLocationCity(BuildContext context) async {
    try {
      Position position = await Utils.determinePosition();

      City? city = await ApiCall.getCityFromCoordinates(position.latitude, position.longitude);
      if (city == null) {
        return;
      }
      WeatherData weatherData = await ApiCall.getWeatherData(city.lat, city.lon);

      var cityBox = Hive.box<City>('cities');
      var newCity = City(
        name: city.name,
        lat: city.lat,
        lon: city.lon,
        country: city.country,
        state: city.state,
        weatherData: weatherData,
      );

      if (!cityBox.values.any((c) => c.name == newCity.name && c.state == newCity.state && c.country == newCity.country)) {
        cityBox.add(newCity);
        AppWidgets.customSnackBar(context, 'Ville ${city.name} Ajouter avec Succes !');
      }
      else{
        AppWidgets.customSnackBar(context, 'Ville déjà présente dans votre liste');
      }

    } catch (e) {
      throw Exception("Erreur lors de l'ajout de la ville : $e");
    }
  }

  /// Retrieves the current geographic location of the user.
  /// Returns a [Position] object containing latitude and longitude.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission de localisation refusée.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission de localisation refusée définitivement.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}