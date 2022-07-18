import 'package:flutter/material.dart';
import 'all_cady_info.dart';

class CadyTracking extends StatelessWidget {
  const CadyTracking({Key? key}) : super(key: key);

  static const routeName = '/CadyTracking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Caddy Tracking',
              style: Theme.of(context).textTheme.headline3),
        ),
        body: const AllCadyInfo());
  }
}
