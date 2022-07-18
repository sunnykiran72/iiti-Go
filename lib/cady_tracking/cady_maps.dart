import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iiti_go/traccar/device_position.dart';

import '../traccar/traccar.dart';

class CadyLiveTracking extends StatefulWidget {
  final List<int> deviceNoIds;
  final String from;
  final String to;
  const CadyLiveTracking(
      {Key? key,
      required this.deviceNoIds,
      required this.from,
      required this.to})
      : super(key: key);

  @override
  State<CadyLiveTracking> createState() => _CadyLiveTrackingState();
}

class _CadyLiveTrackingState extends State<CadyLiveTracking> {
  StreamSubscription? deviceStreamSub;
  GoogleMapController? _controller;
  CameraPosition? initialCamPosition;
  late BitmapDescriptor markerIcon;
  Set<Marker> cadyMarkers = {};
  Set<Circle> accuracyCircles = {};
  var availableCaddies = <DevicePosition>[];

  creatingMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/navigation.png');
  }

  @override
  void initState() {
    creatingMarkerIcon();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    disposeStreamFunctions();
    deviceStreamSub?.cancel();
    super.dispose();
  }

  Stream<List<DevicePosition>> getData() async* {
    getConnection();
    final pos = await positions(widget.deviceNoIds);
    yield* pos;
  }

  void updateNewData(List<DevicePosition> pos) async {
    availableCaddies = pos;
    initialCamPosition ??= CameraPosition(
      target: LatLng(availableCaddies[0].geoPoint.latitude,
          availableCaddies[0].geoPoint.longitude),
      zoom: 17.5,
      tilt: 30,
    );
    updateMarkerAndCircle();
  }

  googleMapCameraUpdate(double lat, double lon) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lon),
      zoom: 17.5,
      tilt: 40,
    )));
  }

  Widget cadyLocationPoints(BuildContext context) {
    return Positioned(
        left: 80,
        bottom: 25,
        right: 0,
        child: Card(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            shadowColor: const Color.fromARGB(255, 4, 87, 151),
            elevation: 18,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(40))),
            child: SizedBox(
              width: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 0, 15),
                      child: Text(
                        'Available vehicles',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 12,
                          spacing: 12,
                          children: availableCaddies.map((caddy) {
                            return ActionChip(
                                onPressed: () {
                                  googleMapCameraUpdate(caddy.geoPoint.latitude,
                                      caddy.geoPoint.longitude);
                                },
                                label: Text(
                                    'caddy 0${availableCaddies.indexOf(caddy) + 1}'),
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                                labelPadding: const EdgeInsets.all(6),
                                avatar: const CircleAvatar(
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Color.fromARGB(255, 241, 90, 90),
                                  ),
                                  backgroundColor: Colors.white70,
                                ));
                          }).toList()),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.from} <--> ${widget.to}',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 16, color: Colors.white)),
        ),
        body: StreamBuilder<List<DevicePosition>>(
            stream: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                updateNewData(snapshot.data!);
                return Stack(children: [
                  trackingMap(),
                  cadyLocationPoints(context),
                ]);
              }

              return Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: Text(
                  'Currently we are facing an error of \n ${snapshot.error} , please try later',
                  style: Theme.of(context).textTheme.headline2,
                )),
              );
            }));
  }

  Widget trackingMap() {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: initialCamPosition!,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      markers: cadyMarkers,
      circles: accuracyCircles,
    );
  }

  void updateMarkerAndCircle() {
    for (var caddy in availableCaddies) {
      cadyMarkers.add(Marker(
        rotation: caddy.geoPoint.heading!,
        markerId: MarkerId('caddy 0${availableCaddies.indexOf(caddy)}'),
        icon: markerIcon,
        position: LatLng(caddy.geoPoint.latitude, caddy.geoPoint.longitude),
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
      ));

      accuracyCircles.add(Circle(
          zIndex: 1,
          circleId:
              CircleId('Accuracy of caddy 0${availableCaddies.indexOf(caddy)}'),
          center: LatLng(caddy.geoPoint.latitude, caddy.geoPoint.longitude),
          radius: caddy.geoPoint.accuracy!,
          fillColor: Colors.lightBlue.shade100.withOpacity(0.3),
          strokeWidth: 3,
          strokeColor: Colors.blue.shade300));
    }
  }
}
