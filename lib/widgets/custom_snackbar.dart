import 'package:flutter/material.dart';

class CustomSnackBar {
  final String content;
  final BuildContext context;

  CustomSnackBar({
    required this.content,
    required this.context,
  });

  void snackbar() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            Expanded(
              child: Text(
                content,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
  }
}
