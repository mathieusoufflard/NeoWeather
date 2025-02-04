import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/model/daily_temperature.dart';

void main() {
  group('DailyTemperature Tests', () {
    test('DailyTemperature.fromJson creates an instance from JSON', () {
      // Exemple de chaîne JSON
      const jsonString = '''{
        "min": 14.0,
        "max": 16.0
      }''';

      // Conversion du JSON en Map
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Création de l'instance DailyTemperature à partir du JSON
      final dailyTemperature = DailyTemperature.fromJson(json);

      // Vérification des propriétés
      expect(dailyTemperature.min, 14.0);
      expect(dailyTemperature.max, 16.0);
    });
  });
}
