/// Represents the daily temperature range.
///
/// This class stores the minimum and maximum temperatures for a given day.
class DailyTemperature {
  /// Minimum temperature in degrees Celsius.
  final double min;

  /// Maximum temperature in degrees Celsius.
  final double max;

  /// Creates an instance of [DailyTemperature].
  ///
  /// - [min]: The minimum temperature for the day.
  /// - [max]: The maximum temperature for the day.
  DailyTemperature({
    required this.min,
    required this.max,
  });

  /// Factory constructor that creates a [DailyTemperature] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing daily temperature data.
  /// - Returns a [DailyTemperature] instance.
  factory DailyTemperature.fromJson(Map<String, dynamic> json) {
    return DailyTemperature(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );
  }
}
