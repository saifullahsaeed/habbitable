import 'package:flutter/material.dart';

class InitialsImagePlaceholder extends StatelessWidget {
  final String name;
  final int radius;
  const InitialsImagePlaceholder(
      {super.key, required this.name, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return CircleAvatar(
        radius: radius.toDouble(),
        child: Icon(Icons.person),
      );
    }
    if (name.length == 1) {
      return CircleAvatar(
        radius: radius.toDouble(),
        child: Text(name),
      );
    }
    if (name.split(' ').length == 1) {
      String initials = name.length > 1
          ? name.split(' ').map((e) => e[0]).take(2).join()
          : name[0];
      return CircleAvatar(
        radius: radius.toDouble(),
        child: Text(initials,
            style: TextStyle(
              fontSize: radius * 0.5,
              fontWeight: FontWeight.w600,
            )),
      );
    }
    return CircleAvatar(
      radius: radius.toDouble(),
      child: Text(
        name.split(' ').map((e) => e[0]).take(2).join(),
        style: TextStyle(
          fontSize: radius * 0.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
