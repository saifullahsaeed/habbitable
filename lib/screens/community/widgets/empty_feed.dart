import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmptyFeed extends StatelessWidget {
  const EmptyFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Icon(
          CupertinoIcons.group_solid,
          size: 40,
          color: Get.theme.colorScheme.primary,
        ),
        const SizedBox(height: 10),
        Text(
          "No posts found",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Explore clubs to join and start your journey to a healthier lifestyle.",
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.toNamed('/explore');
          },
          child: Text(
            "Explore clubs",
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
