import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/strings_constants.dart';

class ReportAnIssue extends StatelessWidget {
  const ReportAnIssue({Key? key}) : super(key: key);

  Future<void> sendEmail() async {
    final urlString =
        'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    await launch(urlString);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          minimumSize: const Size(double.infinity, 6)),
      icon: const Icon(Icons.report_gmailerrorred),
      onPressed: () {
        sendEmail();
      },
      label:
          Text('Report an issue', style: Theme.of(context).textTheme.headline2),
    );
  }
}
