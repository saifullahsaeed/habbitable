import 'package:flutter/material.dart';

class ClubScreen extends StatelessWidget {
  final String clubId;
  const ClubScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Club"),
      ),
      body: Column(
        children: [
          Text("Club"),
        ],
      ),
    );
  }
}
