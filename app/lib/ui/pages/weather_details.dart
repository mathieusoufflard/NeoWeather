import 'package:app/model/city.dart';
import 'package:app/ui/widget_utils/gradient_scaffold.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

/// Represents the detailed weather information for a specific city.
///
/// This class displays detailed weather data for a city including
/// temperature, humidity, wind speed, UV index, weather alerts, and more.
class WeatherDetails extends StatelessWidget {
  final City _city;

  /// Constructor for the WeatherDetails class.
  ///
  /// - [city] : The city for which the weather details are displayed.
  const WeatherDetails(this._city, {super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                backButton(context),
                title(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mainData(),
                    weatherAlertCard(),
                    weatherByHourCard(),
                    weatherByDayCard(),
                    weatherSunsetCard(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        weatherHumidityCard(),
                        weatherVisibilityCard(),
                        weatherWindSpeedCard(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        weatherUVCard(),
                        weatherPressureCard(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Displays the back button to navigate back to the previous screen.
  ///
  /// - [context] : The BuildContext for navigation.
  Widget backButton(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Image.asset(
      'assets/navigation/back_arrow.png',
      color: Colors.black,
      scale: 1.75,
    ),
  );

  /// Displays the title with the city's name at the top.
  title() => Expanded(
    child: Center(
      child: AppWidgets.customText(
          text: _city.name,
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis
      ),
    ),
  );

  /// Displays the main weather data, including temperature, weather description, and min/max temperatures.
  Widget mainData() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              Utils.getWeatherIcon(_city.weatherData!.current.weather.id),
              scale: 1.5,
            ),
          ),
          AppWidgets.customText(text: _city.weatherData!.current.temp.round().toString(), color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ],
      ),
      AppWidgets.customText(text: _city.weatherData!.current.weather.description, color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      AppWidgets.customText(text: 'Resentie ${_city.weatherData!.current.feelsLike.round().toString()}°', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppWidgets.customText(text: 'min: ${_city.weatherData!.daily[0].temp.min.round()}', color: Colors.white, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AppWidgets.customText(text: 'max: ${_city.weatherData!.daily[0].temp.max.round()}', color: Colors.white, fontSize: 16),
          ),
        ],
      )
    ],
  );

  /// Displays the weather alert information for the city, if any alerts are present.
  weatherAlertCard(){
    if(_city.weatherData!.alerts == null){
      return Container();
    }
    return AppWidgets.customIntrinsicCard(
      paddingLeft: 20,
      paddingRight: 20,
      color: const Color.fromRGBO(216, 0, 4, 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppWidgets.customText(text: 'Alerte', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18,),
          AppWidgets.customText(text: _city.weatherData!.alerts![0].senderName, color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 18,),
          AppWidgets.customText(text: _city.weatherData!.alerts![0].event, color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppWidgets.customText(text: 'Début ${Utils.dtToHourMinute(_city.weatherData!.alerts![0].start, _city.weatherData!.timezone)}', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              AppWidgets.customText(text: 'Fin ${Utils.dtToHourMinute(_city.weatherData!.alerts![0].end, _city.weatherData!.timezone)}', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ],
          ),
          const SizedBox(height: 18,),
          SizedBox(
            height: 14 * 10 + 20,
            child: SingleChildScrollView(
              child: AppWidgets.customText(text: _city.weatherData!.alerts![0].description, color: Colors.white, fontSize: 14, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  /// Displays the hourly weather forecast for the next 24 hours.
  weatherByHourCard() => AppWidgets.customCard(
    paddingLeft: 20,
    paddingRight: 20,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Prévision par heure', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _city.weatherData!.hourly.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidgets.customText(text: '${_city.weatherData!.hourly[index].temp.round()}°', color: Colors.white, fontSize: 16),
                    const SizedBox(height: 3),
                    Image.asset(Utils.getWeatherIcon(_city.weatherData!.hourly[index].weather.id), scale: 2.5,),
                    const SizedBox(height: 3),
                    AppWidgets.customText(text: '${Utils.dtToHour(_city.weatherData!.hourly[index].dt, _city.weatherData!.timezone)}:00', color: Colors.white, fontSize: 14,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  /// Displays the daily weather forecast for the upcoming days.
  weatherByDayCard() => AppWidgets.customCard(
    paddingLeft: 20,
    paddingRight: 20,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Prévision par jours', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _city.weatherData!.daily.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidgets.customText(text: '${_city.weatherData!.daily[index].temp.min.round()}°', color: Colors.white, fontSize: 16),
                    AppWidgets.customText(text: '${_city.weatherData!.daily[index].temp.max.round()}°', color: Colors.white, fontSize: 16),
                    const SizedBox(height: 3),
                    Image.asset(Utils.getWeatherIcon(_city.weatherData!.daily[index].weather.id), scale: 2.5,),
                    const SizedBox(height: 3),
                    AppWidgets.customText(text: Utils.dtDay(_city.weatherData!.daily[index].dt, _city.weatherData!.timezone), color: Colors.white, fontSize: 14,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  /// Displays the sunrise and sunset times for the city.
  weatherSunsetCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 20,
    paddingRight: 20,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Lever et coucher du soleil', color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/weather_icon/clear_sky.png', scale: 2,),
            AppWidgets.customText(text: Utils.dtToHourMinute(_city.weatherData!.current.sunrise, _city.weatherData!.timezone), color: Colors.white, fontSize: 10)
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/weather_icon/sunset.png', scale: 2.2,),
            AppWidgets.customText(text: Utils.dtToHourMinute(_city.weatherData!.current.sunset, _city.weatherData!.timezone), color: Colors.white, fontSize: 10)
          ],
        ),
      ],
    ),
  );

  /// Displays the current humidity for the city.
  weatherHumidityCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 20,
    paddingRight: 10,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Humidité', color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        AppWidgets.customText(text: '${_city.weatherData!.current.humidity}%', color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)
      ],
    ),
  );

  /// Displays the current visibility for the city.
  weatherVisibilityCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 10,
    paddingRight: 10,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Visibilité', color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppWidgets.customText(text: (_city.weatherData!.current.visibility / 1000).round().toString(),
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            AppWidgets.customText(text: 'km', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
          ],
        ),
      ],
    ),
  );

  /// Displays the current wind speed for the city.
  weatherWindSpeedCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 10,
    paddingRight: 20,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Vent', color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        AppWidgets.customText(text: (_city.weatherData!.current.windSpeed * 3.6).round().toString(),
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        AppWidgets.customText(text: 'km/h', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
      ],
    ),
  );

  /// Displays the current UV index for the city.
  weatherUVCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 20,
    paddingRight: 10,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Indice UV', color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        AppWidgets.customText(text: '${_city.weatherData!.current.uvi}', color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)
      ],
    ),
  );

  /// Displays the current air pressure for the city.
  weatherPressureCard() => AppWidgets.customIntrinsicCard(
    paddingLeft: 10,
    paddingRight: 20,
    color: const Color.fromRGBO(16, 64, 132, 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppWidgets.customText(text: 'Préssion', color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        AppWidgets.customText(text: _city.weatherData!.current.pressure.toString(), color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        AppWidgets.customText(text: 'hPa', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
      ],
    ),
  );
}
