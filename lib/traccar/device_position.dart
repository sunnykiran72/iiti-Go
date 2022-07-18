import 'package:geopoint/geopoint.dart';

/// A class to handle a device position

class DevicePosition {
  final int id;

  /// The position database id
  final GeoPoint geoPoint;
  DateTime date = DateTime.now();

  /// Create a device position from json

  DevicePosition.noData()
      : id = 0,
        geoPoint = GeoPoint(
          latitude: 0,
          longitude: 0,
        );

  DevicePosition.fromJson(Map<String, dynamic> data,
      {String timeZoneOffset = "0"})
      : id = int.parse(data["id"].toString()),
        geoPoint = GeoPoint(
            name: data["id"].toString(),
            latitude: double.parse(data["latitude"].toString()),
            longitude: double.parse(data["longitude"].toString()),
            speed: double.parse(data["speed"].toString()),
            heading: double.parse(data["course"].toString()),
            accuracy: double.parse(data["accuracy"].toString())) {
    date = dateFromUtcOffset(data["fixTime"].toString(), timeZoneOffset);
  }
}

/// parse a date
DateTime dateFromUtcOffset(String dateStr, String timeZoneOffset) {
  DateTime d = DateTime.parse(dateStr);
  if (timeZoneOffset.startsWith("+")) {
    final of = int.parse(timeZoneOffset.replaceFirst("+", ""));
    d = d.add(Duration(hours: of));
  } else if (timeZoneOffset.startsWith("-")) {
    final of = int.parse(timeZoneOffset.replaceFirst("-", ""));
    d = d.subtract(Duration(hours: of));
  }
  return d;
}
