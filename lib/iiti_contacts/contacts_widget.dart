import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsCard extends StatelessWidget {
  final String title;
  final Map<String, List<String>> contactDetails;
  final Color color;
  const ContactsCard(
      {Key? key,
      required this.title,
      required this.contactDetails,
      required this.color})
      : super(key: key);

  List<DataRow> contactDetailsTable(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    print(h);
    print(w);
    List<DataRow> table = [];
    contactDetails.forEach((key, value) {
      table.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 135,
          child: Center(
            child: Text(key,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: color, fontSize: 14)),
          ),
        )),
        DataCell(TextButton(
            child: Text(value[1],
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: color, fontSize: 14)),
            onPressed: () {
              if (!value[1].contains('-')) {
                final Uri _url =
                    Uri.parse('mailto:<${value[1]}>?subject=&body=');
                launchUrl(_url);
              }
            })),
        DataCell(TextButton(
            child: Text(value[0],
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: color, fontSize: 15)),
            onPressed: () {
              final Uri _url = Uri.parse('tel:${value[0]}');
              launchUrl(_url);
            })),
      ]));
    });

    return table;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
      elevation: 5,
      shadowColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Text(title,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: color, fontSize: 17)),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      dataRowHeight: 55,
                      columns: [
                        DataColumn(
                            label: Text('Name',
                                style: Theme.of(context).textTheme.headline2!)),
                        DataColumn(
                            label: Text('   E mail',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.headline2!)),
                        DataColumn(
                            label: Text('Phone Number',
                                style: Theme.of(context).textTheme.headline2!))
                      ],
                      rows: contactDetailsTable(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
