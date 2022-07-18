import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iiti_go/cady_tracking/no_available_tracking.dart';
import 'package:iiti_go/common_widgets/searching_widget/location_chips.dart';
import 'package:iiti_go/traccar/traccar.dart';
import '../../cady_tracking/cady_maps.dart';
import '../cady_schedule/cady_timetable.dart';
import '../constants/list_constants.dart';

class TrackingSearchBox extends StatefulWidget {
  const TrackingSearchBox({Key? key}) : super(key: key);

  @override
  State<TrackingSearchBox> createState() => _TrackingSearchBoxState();
}

class _TrackingSearchBoxState extends State<TrackingSearchBox> {
  var from = 'Tap to select a point';
  var to = 'Tap to select a point';
  var possibleRouteIds = [];
  var searchingData = false;

  bool notFoundTrackingData = false;

  Future placesBottomSheet(BuildContext context, bool start) {
    return showModalBottomSheet(
        // isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 30),
                  child: Text(
                    ' Select a Point',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                buildChips(start),
              ],
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15))),
          );
        });
  }

  Widget start(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'from :',
          style: TextStyle(
              color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        ActionChip(
            labelPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            label: Text(
              from,
              style: TextStyle(
                  color: from.contains('point') ? Colors.black54 : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await placesBottomSheet(context, true);
            }),
      ],
    );
  }

  Widget destination(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          '   to :',
          style: TextStyle(
              color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        ActionChip(
            labelPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            label: Text(
              to,
              style: TextStyle(
                  color: to.contains('point') ? Colors.black54 : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await placesBottomSheet(context, false);
            }),
      ],
    );
  }

  Widget locationSearch(BuildContext context) {
    return Card(
        shadowColor: Colors.deepPurple,
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            children: [
              start(context),
              const SizedBox(height: 15),
              destination(context),
              const SizedBox(height: 18),
              searchingData
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 30)),
                      onPressed: startTracking,
                      child: const Text(
                        'search',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
            ],
          ),
        ));
  }

  Widget buildChips(bool starting) {
    final chipSet = LocationChips.chips;
    return Wrap(
      runSpacing: 6,
      spacing: 6,
      children: chipSet
          .map(
            (chip) => ActionChip(
                onPressed: () {
                  if (starting) {
                    setState(() {
                      from = chip.label;
                    });
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      to = chip.label;
                    });
                    Navigator.of(context).pop();
                  }
                },
                backgroundColor: chip.backgroundColor,
                label: Text(chip.label),
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
                labelPadding: const EdgeInsets.all(6),
                avatar: CircleAvatar(
                  child: Text(
                    chip.shorcut,
                    style: TextStyle(
                        color: chip.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white70,
                )),
          )
          .toList(),
    );
  }

  startTracking() async {
    var obj = CadyTimeTable();
    var routeIds = obj.searchingRouteId(start: from, end: to);
    if (routeIds.isNotEmpty) {
      setState(() {
        searchingData = true;
      });
      var geoFenceIds = <int>[];
      routeIdMapGeoFence1.forEach((key, value) {
        if (routeIds.contains(key)) {
          geoFenceIds.add(value);
        }
      });

      try {
        var deviceNos = <int>[];
        var allDevicesInfo = await allDevicesData();
        //log('${allDevicesInfo.data}');
        // for (var deviceInfo in (allDevicesInfo)) {
        //   var fenceList = deviceInfo['geofenceIds'];
        //   if (fenceList.isNotEmpty) {
        //     for (int id in fenceList) {
        //       if (geoFenceIds.contains(id)) {
        //         deviceNos.add(int.parse(deviceInfo['id'].toString()));
        //       }
        //     }
        //   }
        // }
        if (deviceNos.isNotEmpty) {
          log('$deviceNos');
          setState(() {
            searchingData = false;
          });

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  CadyLiveTracking(from: from, to: to, deviceNoIds: deviceNos),
            ),
          );
        } else {
          setState(() {
            searchingData = false;
            notFoundTrackingData = true;
          });
        }
      } on Exception catch (error) {
        setState(() {
          searchingData = false;
          notFoundTrackingData = true;
        });

        // TODO
      }
    } else {
      setState(() {
        searchingData = false;
        notFoundTrackingData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        locationSearch(context),
        const SizedBox(height: 15),
        if (notFoundTrackingData)
          const NoTrackingData(
              message:
                  ' Sorry, Currently no vehicle is working right now. please try after sometime')
      ],
    );
  }
}
