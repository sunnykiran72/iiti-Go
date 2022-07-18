import 'package:flutter/material.dart';
import 'package:iiti_go/constants/colors_constants.dart';
import 'package:iiti_go/iiti_contacts/contacts_widget.dart';

class IITIContacts extends StatelessWidget {
  const IITIContacts({Key? key}) : super(key: key);

  static const routeName = '/iitiContacts';

  final contactDetailsList = const [
    ContactsCard(
        title: 'Emergency Contact Numbers (24/7)',
        contactDetails: {
          'Health Center (OPD)': ['07316603571', '-'],
          'Health Center (Ambulance)': ['7509062832', '-'],
          'Health Center (Emergency Section)': ['07316603187', '-'],
          'Emergency Control Room': ['9589518290', '-'],
          'Security supervisor': ['6265224771', '-'],
        },
        color: c1),
    ContactsCard(
        title: 'Transport office',
        contactDetails: {
          'Mukesh yadav (supervisor)': ['7509062834', 'transport@iiti.ac.in'],
          'Shiv charan Patel (supervisor)': [
            '7509062831',
            'transport@iiti.ac.in'
          ]
        },
        color: c3),
    ContactsCard(
        title: 'APJ Hall of Residence',
        contactDetails: {
          'Dr.Harekrishna yadav (Warden)': [
            '07316603561',
            'warden.apj@iiti.ac.in'
          ],
          'Mr.Gaurav Tiwari (Junior Assistant)': [
            '9755777084',
            'office.apj@iiti.ac.in'
          ],
          'Mr.Himmat singh verma (Attendant)': [
            '6260158083',
            'office.apj@iiti.ac.in'
          ]
        },
        color: c4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('iiti Contacts', style: Theme.of(context).textTheme.headline3),
      ),
      body: ListView.builder(
        itemCount: contactDetailsList.length,
        itemBuilder: (context, index) {
          return contactDetailsList[index];
        },
      ),
    );
  }
}
