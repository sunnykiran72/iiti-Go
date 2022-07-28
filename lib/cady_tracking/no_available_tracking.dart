import 'package:flutter/material.dart';
import 'package:iiti_go/cady_schedule/cady_schedule.dart';

class NoTrackingData extends StatelessWidget {
  final String message;
  const NoTrackingData({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_dissatisfied,
              size: 80, color: Colors.black38),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(137, 45, 28, 28),
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextButton(
            child: const Text(
              'Click to check Caddy Schedule',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CadySchedule.routeName);
            },
          )
        ],
      ),
    ));
  }
}
