import 'package:flutter/material.dart';
import 'package:iiti_go/cady_schedule/search_box.dart';

class CadySchedule extends StatelessWidget {
  const CadySchedule({Key? key}) : super(key: key);
  static const routeName = '/CadySchedule';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caddy Schedule',
            style: Theme.of(context).textTheme.headline3),
      ),
      body: const SingleChildScrollView(child: SearchBox()),
    );
  }
}
