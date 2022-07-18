import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  final IconData iconData;
  final String name;
  final String routeName;

  const HomeIcons(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        height: 140,
        width: 140,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 17,
                spreadRadius: 4,
                offset: const Offset(5, 5),
              ),
              const BoxShadow(
                color: Colors.white,
                blurRadius: 17,
                spreadRadius: 4,
                offset: Offset(-5, -5),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(name,
                  // softWrap: true,
                  textScaleFactor: 1.1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
            ),
          ],
        ),
      ),
    );
  }
}
