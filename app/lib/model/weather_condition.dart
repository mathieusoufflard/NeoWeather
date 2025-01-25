class WeatherCondition {
  final int id;
  final String main;
  final String description;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      main: json['main'],
      description: json['description'],
    );
  }
}