import 'package:flutter/material.dart';
import 'package:iiti_go/cady_schedule/cady_timetable.dart';
import 'package:iiti_go/cady_schedule/schedule_table.dart';
import 'package:iiti_go/common_widgets/searching_widget/location_chips.dart';
import '../../constants/list_constants.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  var from = 'Tap to select a point';
  var to = 'Tap to select a point';
  List<List<String>> timeTable = [];
  List<List<String>> places = [];
  List<int> cadyRouteId = [];
  var noData = false;
  var showData = false;

  Future placesBottomSheet(BuildContext context, bool from) {
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
                buildChips(from),
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
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            children: [
              start(context),
              const SizedBox(height: 15),
              destination(context),
              const SizedBox(height: 18),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 30)),
                  onPressed: startSearching,
                  child: const Text(
                    'search',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))
            ],
          ),
        ));
  }

  Widget buildChips(bool start) {
    final chipSet = LocationChips.chips;
    return Wrap(
      runSpacing: 6,
      spacing: 6,
      children: chipSet
          .map(
            (chip) => ActionChip(
                onPressed: () {
                  if (start) {
                    setState(() {
                      from = chip.label;
                      showData = false;
                      noData = false;
                    });
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      to = chip.label;
                      showData = false;
                      noData = false;
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

  Widget zeroData() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 25),
        Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.black38),
        SizedBox(height: 15),
        SizedBox(
            width: 250,
            child: Text(
              'Sorry, Currently no caddy is scheduled on this route',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))
      ],
    ));
  }

  startSearching() {
    var obj = CadyTimeTable();
    var routeId = obj.searchingRouteId(start: from, end: to);
    timeTable.clear();
    places.clear();
    if (routeId.isNotEmpty) {
      for (var i in routeId) {
        timeTable.add(cadyIdWithTime[i]!);
        places.add(cadyRoutesWithId[i]!);
      }
      setState(() {
        showData = true;
      });
    } else {
      setState(() {
        noData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        locationSearch(context),
        const SizedBox(height: 15),
        if (noData) zeroData(),
        if (showData)
          ScheduleTable(
            timeSlots: timeTable,
            places: places,
            start: from,
            end: to,
          ),
      ],
    );
  }
}
