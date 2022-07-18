import 'package:flutter/material.dart';

class ShareApp extends StatelessWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          minimumSize: const Size(double.infinity, 15)),
      onPressed: () {},
      label: Text(
        'Share App',
        style: Theme.of(context).textTheme.headline2,
      ),
      icon: const Icon(
        Icons.share,
      ),
    );
  }
}
