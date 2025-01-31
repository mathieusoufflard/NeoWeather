/// Represents the weather condition for a specific time period.
///
/// This class stores information about the weather status, including
/// an identifier, a general description, and a more detailed description.
class WeatherCondition {
  /// Unique identifier for the weather condition (corresponding to OpenWeatherMap codes).
  ///
  /// Example:
  /// - `200` for thunderstorms with light rain
  /// - `500` for light rain
  final int id;

  /// Short description of the weather condition (e.g., "Rain", "Clouds").
  final String main;

  /// More detailed description of the weather condition (e.g., "light rain", "overcast clouds").
  final String description;

  /// Creates a [WeatherCondition] instance.
  ///
  /// - [id]: The unique weather condition code.
  /// - [main]: A general classification of the weather.
  /// - [description]: A detailed textual description of the weather.
  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
  });

  /// Factory constructor that creates a [WeatherCondition] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing weather condition data.
  /// - Returns a [WeatherCondition] instance.
  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      main: json['main'],
      description: json['description'],
    );
  }
}
