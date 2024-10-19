import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcomming",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See all"),
                ),
              ],
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.habits.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => HabbitCard(
                    habit: controller.habits[index],
                    onCompleted: (isCompleted) {
                      isCompleted
                          ? controller
                              .completeHabit(controller.habits[index].id)
                          : controller.undoHabit(controller.habits[index].id);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
