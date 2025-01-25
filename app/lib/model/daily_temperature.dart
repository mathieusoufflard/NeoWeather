class DailyTemperature {
  final double min;
  final double max;

  DailyTemperature({
    required this.min,
    required this.max,
  });

  factory DailyTemperature.fromJson(Map<String, dynamic> json) {
    return DailyTemperature(
      min: json['min'],
      max: json['max'],
    );
  }
}