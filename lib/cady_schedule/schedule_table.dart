import 'package:flutter/material.dart';

class ScheduleTable extends StatelessWidget {
  final List<List<String>> timeSlots;
  final List<List<String>> places;
  final String start;
  final String end;

  const ScheduleTable({
    Key? key,
    required this.timeSlots,
    required this.places,
    required this.start,
    required this.end,
  }) : super(key: key);

  placesText(
      {required List<String> routePlaces,
      required int startNo,
      required int endNo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 140,
        child: Center(
          child: RichText(
              text: TextSpan(
            children: List<TextSpan>.generate(routePlaces.length, (index) {
              return TextSpan(
                  text: ' ${routePlaces[index]}  ',
                  style: TextStyle(
                      color: (startNo == index || endNo == index)
                          ? Colors.deepPurple
                          : Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13));
            }),
          )),
        ),
      ),
    );
  }

  List<DataRow> dataRow() {
    List<DataRow> rows = [];
    for (int i = 0; i < places.length; i++) {
      var startId = places[i].indexOf(start);
      var endId = places[i].indexOf(end);
      rows.add(DataRow(cells: [
        DataCell(
            placesText(routePlaces: places[i], startNo: startId, endNo: endId)),
        DataCell(timeSlotsText(timeSlots[i]))
      ]));
    }
    return rows;
  }

  Widget timeSlotsText(List<String> cadyTimeSlots) {
    var time = '';
    for (var slot in cadyTimeSlots) {
      time += ' $slot  ';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 200,
        child: Center(
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontSize: 13),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Scrollbar(
              //isAlwaysShown: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    dataRowHeight: 100,
                    columns: const [
                      DataColumn(
                          label: Center(
                              child: Text(
                        'Route',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))),
                      DataColumn(
                          label: Center(
                              child: Text(
                        'Time Slots',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))),
                    ],
                    rows: dataRow()),
              ),
            )));
  }
}
