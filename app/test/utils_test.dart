import 'package:flutter_test/flutter_test.dart';
import 'package:app/utils/utils.dart';
import 'package:app/model/city.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  // Initialize time zones before running tests
  setUpAll(() {
    tzdata.initializeTimeZones();
  });

  group('Utils Class Tests', () {
    test('getWeatherIcon returns correct icon path', () {
      expect(Utils.getWeatherIcon(800), 'assets/weather_icon/clear_sky.png');
      expect(Utils.getWeatherIcon(500), 'assets/weather_icon/shower_rain.png');
      expect(Utils.getWeatherIcon(200), 'assets/weather_icon/thunderstorm.png');
    });

    test('removeDuplicateCity removes cities with same state and country', () {
      List<City> cities = [
        City(name: 'Paris', lat: 48.8566, lon: 2.3522, state: 'Ile-de-France', country: 'France'),
        City(name: 'Paris', lat: 48.8566, lon: 2.3522, state: 'Ile-de-France', country: 'France'),
        City(name: 'Lyon', lat: 45.764, lon: 4.8357, state: 'Auvergne-Rhône-Alpes', country: 'France')
      ];

      List<City> filteredCities = Utils.removeDuplicateCity(cities);

      expect(filteredCities.length, 2);
    });

    test('removeAlreadyNowCites filters out already added cities', () {
      List<City> toAddCities = [
        City(name: 'Paris', lat: 48.8566, lon: 2.3522, state: 'Ile-de-France', country: 'France'),
        City(name: 'Lyon', lat: 45.764, lon: 4.8357, state: 'Auvergne-Rhône-Alpes', country: 'France')
      ];

      List<City> addedCities = [
        City(name: 'Paris', lat: 48.8566, lon: 2.3522, state: 'Ile-de-France', country: 'France')
      ];

      List<City> result = Utils.removeAlreadyNowCites(toAddCities, addedCities);
      expect(result.length, 1);
      expect(result[0].name, 'Lyon');
    });

    test('dtToHour converts timestamp to hour correctly', () {
      int timestamp = 1738263600; // Example timestamp
      String hour = Utils.dtToHour(timestamp, "Europe/Paris");
      expect(hour, isNotEmpty);
    });

    test('dtToHourMinute converts timestamp to hour and minute correctly', () {
      int timestamp = 1738263600;
      String hourMinute = Utils.dtToHourMinute(timestamp, "Europe/Paris");
      expect(hourMinute, isNotEmpty);
    });

    test('dtDay returns correct weekday in French', () {
      int timestamp = 1738263600;
      String day = Utils.dtDay(timestamp, "Europe/Paris");
      expect(day, anyOf(['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']));
    });

    test('isLocalDtHaveDelay detects outdated timestamps', () {
      int outdatedTimestamp = DateTime.now().subtract(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000;
      int recentTimestamp = DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch ~/ 1000;

      expect(Utils.isLocalDtHaveDelay(outdatedTimestamp, "Europe/Paris"), isTrue);
      expect(Utils.isLocalDtHaveDelay(recentTimestamp, "Europe/Paris"), isFalse);
    });

    test('usDayToFrDay converts English weekdays to French', () {
      expect(Utils.usDayToFrDay('Monday'), 'Lundi');
      expect(Utils.usDayToFrDay('Tuesday'), 'Mardi');
      expect(Utils.usDayToFrDay('Sunday'), 'Dimanche');
    });
  });
}
