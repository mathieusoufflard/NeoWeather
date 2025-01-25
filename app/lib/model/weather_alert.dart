class WeatherAlert {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;

  WeatherAlert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'],
      event: json['event'],
      end: json['end'],
      start: json['start'],
      description: json['description'],
    );
  }
}