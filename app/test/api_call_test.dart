import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/utils/api_call.dart';
import 'package:app/model/city.dart';
import 'package:app/model/weather_data.dart';
import 'api_call_test.mocks.dart';

void main() {
  late MockClient mockHttpClient;

  setUp(() async {
    mockHttpClient = MockClient();
    await dotenv.load(); // Charge les variables d'environnement
  });

  group('ApiCall Tests', () {
    test('getCityCoordinates returns a list of cities', () async {
      // Simule la réponse de l'API OpenWeather
      final mockResponse = jsonEncode([
        {
          "name": "Paris",
          "lat": 48.8566,
          "lon": 2.3522,
          "state": "Île-de-France",
          "country": "FR"
        }
      ]);

      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(mockResponse, 200));

      List<City> cities = await ApiCall.getCityCoordinates("Paris", client: mockHttpClient);

      expect(cities, isNotEmpty);
      expect(cities.first.name, "Paris");
      expect(cities.first.country, "FR");
    });

    test('getWeatherData returns weather data for a city', () async {
      final mockWeatherResponse = jsonEncode({
        "timezone": "Europe/Paris",
        "current": {
          "dt": 1738263600,
          "temp": 10.5,
          "feels_like": 8.5,
          "pressure": 1015,
          "humidity": 75,
          "uvi": 1.0,
          "visibility": 10000,
          "wind_speed": 5.2,
          "weather": [
            {"id": 800, "main": "Clear", "description": "clear sky"}
          ]
        },
        "hourly": [],
        "daily": []
      });

      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(mockWeatherResponse, 200));

      WeatherData weatherData = await ApiCall.getWeatherData(48.8566, 2.3522, client: mockHttpClient);

      expect(weatherData.timezone, "Europe/Paris");
      expect(weatherData.current.temp, inInclusiveRange(-10, 50));
    });

    test('getCityFromCoordinates returns a city', () async {
      final mockCityResponse = jsonEncode([
        {
          "name": "Paris",
          "state": "Île-de-France",
          "country": "FR"
        }
      ]);

      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(mockCityResponse, 200));

      City? city = await ApiCall.getCityFromCoordinates(48.8566, 2.3522, client: mockHttpClient);

      expect(city, isNotNull);
      expect(city!.name, "Paris");
      expect(city.country, "FR");
    });
  });
}
