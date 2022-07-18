import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:iiti_go/constants/strings_constants.dart';
import 'package:iiti_go/traccar/device_position.dart';
import 'package:web_socket_channel/io.dart';

import '../models/traccar_device.dart';

String? cookie;

// authentication method

Future<void> getConnection({String protocol = "http"}) async {
  final addr = "$protocol://$serverUrl/api/session";
  Map<String, String> body = {
    'email': traccarEmail,
    'password': traccarPassword,
  };

  final response = await Dio().post(addr,
      data: body,
      options: Options(contentType: "application/x-www-form-urlencoded"));
  cookie = response.headers["set-cookie"]?[0];
}

// getting stream of data

Future<Stream<dynamic>> positionsStream(List<int> deviceIds) async {
  if (cookie == null) {
    await getConnection();
  }
  var idsQuery = '';
  for (int i = 0; i < deviceIds.length; i++) {
    i < (deviceIds.length - 1)
        ? idsQuery = 'id=${deviceIds[i]}&'
        : idsQuery = 'id=${deviceIds[i]}';
  }

  // "ws://$serverUrl/api/positions/?${iDQueryParam(deviceIds)}" "ws://$serverUrl/api/socket" https://server.traccar.org/api/positions
  final channel = IOWebSocketChannel.connect("ws://$serverUrl/api/socket",
      headers: <String, dynamic>{"Cookie": cookie});
  return channel.stream;
}

/// Get the available devices
Future<Map<int, List<Device>>> allDevicesData() async {
  var geoFenceWithDevices = <int, List<Device>>{};
  print('allDevices');
  if (cookie == null) {
    await getConnection();
  }
  print('-------------------- allDevices  -----------------------');
  final allDevices = await Dio().get("http://$serverUrl/api/devices",
      options: Options(headers: <String, dynamic>{"Cookie": cookie}));
  geoFenceWithDevices = searchingCadyData(allDevices.data);
  print(allDevices);
  print('-------------------- all Over  -----------------------');
  return geoFenceWithDevices;
}

Map<int, List<Device>> searchingCadyData(dynamic deivcesInfo) {
  var geoFenceWithDevices = <int, List<Device>>{};
  for (var device in deivcesInfo) {
    var ids = device['geofenceIds'];

    if (ids.isNotEmpty) {
      if (ids.length == 2) {
        print('111111111111111111');
        var geoWithDev = filteringData(device['id']);
        print('111111111111111111');
        int id = geoWithDev.keys.first;
        geoFenceWithDevices.update(id, (value) {
          value.add(geoWithDev[id]!);
          return value;
        }, ifAbsent: () => [geoWithDev[id]!]);
      } else {
        var dev = Device(
            name: device['name'], deviceId: device['id'], geoFenceIds: ids[0]);

        geoFenceWithDevices.update(ids[0], (value) {
          value.add(dev);
          return value;
        }, ifAbsent: () => [dev]);
      }
    }
  }
  return geoFenceWithDevices;
}

Map<int, Device> filteringData(int deviceId) {
  var geoWithDev = <int, Device>{};
  devicesReportData(deviceId).then((value) {
    for (var device in value.data) {
      if (device['geofenceId'] == 7) {
        geoWithDev[7] = Device(
            name: device['name'], deviceId: device['id'], geoFenceIds: 7);
      }
      if (device['geofenceId'] == 6) {
        geoWithDev[6] = Device(
            name: device['name'], deviceId: device['id'], geoFenceIds: 6);
      }
    }
  }).onError((error, stackTrace) {
    print(error); // 1963-11-22T18:30:00Z
  });

  return geoWithDev;
}

/// Get the available devices
Future<Response<dynamic>> devicesReportData(int deviceId) async {
  if (cookie == null) {
    await getConnection();
  }

  var time = DateTime.now();
  var parm = {
    'deviceId': [deviceId],
    'from': time.subtract(const Duration(minutes: 7)).toUtc().toIso8601String(),
    'to': time.toUtc().toIso8601String()
  };

  final channel = await Dio().get("http://$serverUrl/api/reports/events",
      queryParameters: parm,
      options: Options(headers: <String, dynamic>{"Cookie": cookie}));

  return channel;
}

/// Get the device positions

StreamSubscription<dynamic>? rawPosSub;
final positionsController = StreamController<List<DevicePosition>>.broadcast();
var devicePosMap = <DevicePosition>[];

/// Get the list of device positions
Future<Stream<List<DevicePosition>>> positions(List<int> deviceIds) async {
  final posStream = await positionsStream(deviceIds);

  rawPosSub = posStream.listen((dynamic data) {
    final dataMap = json.decode(data.toString()) as Map<String, dynamic>;
    log('$dataMap');
    if (dataMap.containsKey("positions")) {
      for (final posMap in dataMap["positions"]) {
        DevicePosition pos;
        pos = DevicePosition.fromJson(posMap as Map<String, dynamic>);
        //devicePosMap.add(pos);
        // if (deviceIds.contains(int.parse(posMap["deviceId"].toString()))) {
        //   pos = DevicePosition.fromJson(posMap as Map<String, dynamic>);
        //   devicePosMap.add(pos);
        // }
        devicePosMap = [];
        devicePosMap.add(pos);
        positionsController.sink.add(devicePosMap);
      }
    } else {
      if (devicePosMap.isNotEmpty) {
        positionsController.sink.add(devicePosMap);
      }
    }
  }, cancelOnError: false);
  return positionsController.stream;
}

void disposeStreamFunctions() {
  positionsController.onCancel;
  rawPosSub?.cancel();
}

// void resumeStreamFunctions() {
//   if (positionsController.isPaused) {
//     positionsController.  ;
//   }
// }
