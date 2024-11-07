import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/screens/habit/controllers/controller.dart';

class DeleteHabit extends StatelessWidget {
  final Habit habit;
  final HomeController homeController;
  final HabitScreenController controller;
  const DeleteHabit(
      {super.key,
      required this.habit,
      required this.homeController,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.dialog(
          AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone. '),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  homeController.removeHabit(habit.id);
                  Get.back();
                  Get.back();
                  controller.deleteHabit(habit.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Get.theme.colorScheme.onError,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      icon: Icon(
        Icons.delete,
        color: Get.theme.colorScheme.error,
      ),
    );
  }
}
