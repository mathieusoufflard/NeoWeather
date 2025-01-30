import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class Utils {

  Utils._();

  static String getWeatherIcon(int weatherId) {
    switch (weatherId) {
    // 🌩️ thunderstorm
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

    // ☀️ Clear scy
      case 800:
        return 'assets/weather_icon/clear_sky.png';

    // ⛅ Few clouds
      case 801:
        return 'assets/weather_icon/few_clouds.png';

    // ⛅  Scattered clouds
      case 802:
        return 'assets/weather_icon/scattered_clouds.png';

    // ⛅  Broken clouds
      case 803:
      case 804:
        return 'assets/weather_icon/broken_clouds.png';

    // 🌍 in case of id don't match
      default:
        return 'assets/weather_icon/clear_sky.png';
    }
  }

  static String dtToHour(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);

    return DateFormat('HH').format(localTime);
  }

  static String dtToHourMinute(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);

    return DateFormat('HH:mm').format(localTime);
  }

  static String dtDay(int dt , String timeZone){
    tzdata.initializeTimeZones();

    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt * 1000);
    return usDayToFrDay(DateFormat('EEEE', 'en_US').format(localTime));
  }

  static String usDayToFrDay(String format) {
    switch (format) {
      case'Monday':
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


}