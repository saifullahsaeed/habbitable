import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueCard extends StatelessWidget {
  final String title;
  final String value;
  final int? subtitle;
  const ValueCard(
      {super.key, required this.title, required this.value, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.theme.colorScheme.primary,
              Get.theme.colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Get.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: Get.textTheme.headlineSmall!.copyWith(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: subtitle! > 0
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    subtitle! > 0
                        ? const Icon(
                            Icons.arrow_upward,
                            size: 12,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.arrow_downward,
                            size: 12,
                            color: Colors.red,
                          ),
                    Text(
                      "$subtitle%",
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: subtitle! > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: subtitle! > 0
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            offset: const Offset(0, 1.2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
