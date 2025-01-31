/// Represents a weather alert issued by an official weather authority.
///
/// This class contains details about weather alerts, including the sender,
/// event type, validity period, and description.
class WeatherAlert {
  /// The name of the organization or authority that issued the alert.
  final String senderName;

  /// The type of weather event (e.g., "Thunderstorm Warning", "Flood Alert").
  final String event;

  /// Unix timestamp (UTC) indicating when the alert starts.
  final int start;

  /// Unix timestamp (UTC) indicating when the alert ends.
  final int end;

  /// A detailed description of the alert, explaining the event and its impact.
  final String description;

  /// Creates an instance of [WeatherAlert].
  ///
  /// - [senderName]: The issuing organization.
  /// - [event]: The type of weather alert.
  /// - [start]: The start time of the alert (Unix timestamp).
  /// - [end]: The end time of the alert (Unix timestamp).
  /// - [description]: Detailed information about the alert.
  WeatherAlert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
  });

  /// Factory constructor that creates a [WeatherAlert] instance from a JSON object.
  ///
  /// - [json]: A JSON map containing weather alert data.
  /// - Returns a [WeatherAlert] instance.
  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'],
      event: json['event'],
      start: json['start'],
      end: json['end'],
      description: json['description'],
    );
  }
}
