import 'package:flutter/material.dart';
import 'package:iiti_go/cady_tracking/cady_maps.dart';
import '../constants/list_constants.dart';
import '../models/traccar_device.dart';

class AllCadyWidget extends StatelessWidget {
  final Map<int, List<Device>> fenceIdMapDevices;

  const AllCadyWidget({
    required this.fenceIdMapDevices,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget routeData(List<String> places) {
      var route = '';
      for (var placeId = 0; placeId < places.length; placeId++) {
        if (placeId < places.length - 1) {
          route = route + '  ${places[placeId]} <--> ';
        } else {
          route = route + '  ${places[placeId]} ';
        }
      }

      return Container(
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width - 70,
          child: Text(route, style: Theme.of(context).textTheme.headline2));
    }

    Widget trackingWidget(List<Device> deviceList) {
      var places = routeIdMapGeoFence[deviceList.first.geoFenceIds];

      return InkWell(
        onTap: (() {
          var deviceNos = <int>[];
          for (var i in deviceList) {
            deviceNos.add(i.deviceId);
          }
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CadyLiveTracking(
                from: places!.first, to: places.last, deviceNoIds: deviceNos),
          ));
        }),
        child: SizedBox(
          height: 150,
          child: Card(
            shadowColor: const Color.fromARGB(255, 90, 177, 244),
            elevation: 7,
            margin:
                const EdgeInsets.only(left: 12, right: 8, top: 10, bottom: 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Row(
              children: [
                Container(
                  color: const Color.fromARGB(255, 4, 87, 151),
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('      Route : ',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 21)),
                        routeData(places!)
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
          children: fenceIdMapDevices.values.map((deviceList) {
        return trackingWidget(deviceList);
      }).toList()),
    );
  }
}
