import 'package:flutter/material.dart';
import 'package:habbitable/models/habit.dart';

class HabitScreen extends StatelessWidget {
  final Habit habit;
  const HabitScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Habit'),
      ),
    );
  }
}
