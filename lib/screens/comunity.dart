import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ComunityScreen extends StatelessWidget {
  const ComunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Get.theme.cardColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sunny,
                          color: Get.theme.colorScheme.primary,
                          size: 35,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '6AM Club ',
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '4 habits',
                      style: Get.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 15,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '123 members',
                                style: Get.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
