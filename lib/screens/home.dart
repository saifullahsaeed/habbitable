import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:lottie/lottie.dart';

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
                child: controller.habitsTodaysUpcoming.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/animations/empty.json",
                              frameRate: FrameRate(30),
                              height: 200,
                              width: 200,
                            ),
                            Text(
                              "All done for Today",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.habitsTodaysUpcoming.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => HabbitCard(
                          habit: controller.habitsTodaysUpcoming[index],
                          onCompleted: (isCompleted) {
                            isCompleted
                                ? controller.completeHabit(controller
                                    .habitsTodaysUpcoming[index].id
                                    .toString())
                                : controller.undoHabit(controller
                                    .habitsTodaysUpcoming[index].id
                                    .toString());
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/createhabit');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
