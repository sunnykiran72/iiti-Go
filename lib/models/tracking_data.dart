import 'package:iiti_go/models/traccar_device.dart';

class TrackingData {
  final int geoFenceId;
  final List<Device> deviceDetails;

  TrackingData({required this.geoFenceId, required this.deviceDetails});
}
