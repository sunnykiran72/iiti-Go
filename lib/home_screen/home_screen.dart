import 'package:flutter/material.dart';
import 'package:iiti_go/cady_schedule/cady_schedule.dart';
import 'package:iiti_go/cady_tracking/cady_tracking.dart';
import 'package:iiti_go/home_screen/account_details.dart';
import 'package:iiti_go/home_screen/home_icons.dart';
import 'package:iiti_go/home_screen/logout.dart';
import 'package:iiti_go/home_screen/report_issue.dart';
import 'package:iiti_go/home_screen/share_app_url.dart';

import '../iiti_contacts/iiti_contacts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/HomeScreen';

  Widget trackingWidget(BuildContext context) {
    //var places = routeIdMapGeoFence[deviceList.first.deviceId];
    return InkWell(
      onTap: (() {}),
      child: SizedBox(
        height: 150,
        child: Card(
          shadowColor: const Color.fromARGB(255, 45, 152, 234),
          elevation: 6,
          margin:
              const EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24)),
          ),
          child: Row(
            children: [
              Container(
                color: const Color.fromARGB(255, 4, 87, 151),
                width: 10,
                // height: 180,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('      Route : ',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 21)),

                      //const SizedBox(height: 15),
                      Container(
                          padding: const EdgeInsets.all(18),
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text(
                              'healthcenter -- jcbose -- pod1b -- hub -- sb -- school building',
                              style: Theme.of(context).textTheme.headline2))

                      //const Divider(),
                      // vehicleData(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final checkNetStatus = Provider.of<NetworkStatus>(context);
    // if (checkNetStatus == NetworkStatus.offline) {
    //   CustomSnackBar(
    //       content: 'please check internet connection', context: context);
    // }
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'iiti Go',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 1,
                  shadows: []),
            ),
            actions: [
              const AccountDetails(),
              PopupMenuButton(
                  iconSize: 30,
                  itemBuilder: (context) => [
                        const PopupMenuItem(child: ReportAnIssue()),
                        const PopupMenuItem(child: ShareApp()),
                        const PopupMenuItem(child: Logout()),
                      ]),
            ]),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 20,
                  spacing: 10,
                  children: const [
                    HomeIcons(
                        iconData: Icons.schedule_rounded,
                        name: 'Caddy  Schedule',
                        routeName: CadySchedule.routeName),
                    HomeIcons(
                        iconData: Icons.location_on_rounded,
                        name: 'Caddy  Tracking',
                        routeName: CadyTracking.routeName),
                    HomeIcons(
                        iconData: Icons.person_search_rounded,
                        name: 'iiti Contacts',
                        routeName: IITIContacts.routeName),
                  ],
                ),
                //trackingWidget(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Text('Sai kiran Chowdarapu \n\n       Version 1.0.0',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.grey.shade300,
                        fontSize: 11,
                        letterSpacing: 0.0,
                        shadows: [])),
              ],
            ),
          ),
        ));
  }
}
