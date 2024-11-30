import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class SentRequestItem extends StatelessWidget {
  final FriendRequest request;
  final VoidCallback onWithdraw;

  const SentRequestItem({
    super.key,
    required this.request,
    required this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Get.theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    InitialsImagePlaceholder(
                      name: request.addressee.name,
                      radius: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        request.addressee.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                timeAgo(request.createdAt),
                style: Get.textTheme.bodySmall!.copyWith(
                  color: Get.theme.colorScheme.outline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Waiting for approval. Tap to withdraw request.",
            style: Get.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButtonCustom(
                  onPressed: onWithdraw,
                  color: Get.theme.colorScheme.error,
                  label: "Withdraw Request",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
