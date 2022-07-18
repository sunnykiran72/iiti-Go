import 'package:flutter/material.dart';
import 'package:iiti_go/cady_tracking/cady_widget.dart';
import 'package:iiti_go/models/traccar_device.dart';
import '../traccar/traccar.dart';
import 'no_available_tracking.dart';

class AllCadyInfo extends StatelessWidget {
  const AllCadyInfo({Key? key}) : super(key: key);

  Widget noData(String issue) {
    return Center(child: NoTrackingData(message: issue));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, List<Device>>>(
        future: allDevicesData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 5,
            ));
          }
          if (snapshot.hasError) {
            return noData(
                ' There is some issue. please check your Internet connection');
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return noData(
                  ' Sorry, Currently no vehicle is working right now. please try after sometime');
            }
            return AllCadyWidget(fenceIdMapDevices: snapshot.data!);
          }
          return noData(
              ' Sorry, Currently no vehicle is working right now. please try after sometime');
        });
  }
}
