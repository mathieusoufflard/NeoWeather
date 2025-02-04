import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/city.dart';
import 'package:app/model/weather_data.dart';

void main() {
  group('City Tests', () {
    test('City constructor creates a valid City object', () {
      // Création d'une instance de City avec les données
      final city = City(
        name: 'Paris',       // Paramètre requis
        lat: 48.8566,        // Paramètre requis
        lon: 2.3522,         // Paramètre requis
        state: 'Île-de-France', // Paramètre optionnel
        country: 'FR',       // Paramètre requis
      );

      // Vérification que l'objet City a été créé correctement
      expect(city.name, 'Paris');
      expect(city.lat, 48.8566);
      expect(city.lon, 2.3522);
      expect(city.state, 'Île-de-France');
      expect(city.country, 'FR');
    });

    test('City.fromJson creates a valid City object from JSON', () {
      // Exemple de JSON à tester
      final json = {
        'name': 'Paris',
        'lat': 48.8566,
        'lon': 2.3522,
        'state': 'Île-de-France',
        'country': 'FR',
      };

      // Création d'un objet City à partir du JSON
      final city = City.fromJson(json);

      // Vérification des données dans l'objet City
      expect(city.name, 'Paris');
      expect(city.lat, 48.8566);
      expect(city.lon, 2.3522);
      expect(city.state, 'Île-de-France');
      expect(city.country, 'FR');
    });

    test('City.fromJson handles missing state correctly', () {
      // Exemple de JSON sans état
      final json = {
        'name': 'Paris',
        'lat': 48.8566,
        'lon': 2.3522,
        'country': 'FR',
      };

      // Création d'un objet City à partir du JSON
      final city = City.fromJson(json);

      // Vérification que l'état est null
      expect(city.name, 'Paris');
      expect(city.lat, 48.8566);
      expect(city.lon, 2.3522);
      expect(city.state, isNull);  // Aucun état fourni dans le JSON
      expect(city.country, 'FR');
    });

    test('parseCities converts JSON list to list of City objects', () {
      // Liste de JSON représentant des villes
      final jsonList = [
        {
          'name': 'Paris',
          'lat': 48.8566,
          'lon': 2.3522,
          'state': 'Île-de-France',
          'country': 'FR',
        },
        {
          'name': 'London',
          'lat': 51.5074,
          'lon': -0.1278,
          'state': 'England',
          'country': 'GB',
        },
      ];

      // Utilisation de la méthode parseCities pour convertir le JSON en liste d'objets City
      final cityExample = City(name: '', lat: 0.0, lon: 0.0, country: ''); // Création d'une instance factice de City
      final cities = cityExample.parseCities(jsonList);

      // Vérification que la liste contient bien deux villes
      expect(cities.length, 2);

      // Vérification de la première ville
      expect(cities[0].name, 'Paris');
      expect(cities[0].lat, 48.8566);
      expect(cities[0].lon, 2.3522);
      expect(cities[0].state, 'Île-de-France');
      expect(cities[0].country, 'FR');

      // Vérification de la deuxième ville
      expect(cities[1].name, 'London');
      expect(cities[1].lat, 51.5074);
      expect(cities[1].lon, -0.1278);
      expect(cities[1].state, 'England');
      expect(cities[1].country, 'GB');
    });

    test('parseCities handles empty JSON list', () {
      // Liste JSON vide
      final jsonList = [];

      // Utilisation de la méthode parseCities pour convertir le JSON vide
      final cityExample = City(name: '', lat: 0.0, lon: 0.0, country: ''); // Instance factice
      final cities = cityExample.parseCities(jsonList);

      // Vérification que la liste retournée est vide
      expect(cities.isEmpty, true);
    });
  });
}
