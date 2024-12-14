import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class FriendRequestCard extends StatelessWidget {
  final FriendRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const FriendRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Get.theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.onSurface.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
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
                    request.requester.avatar != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              request.requester.avatar!.url,
                            ),
                          )
                        : InitialsImagePlaceholder(
                            name: request.requester.name,
                            radius: 20,
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        request.requester.name,
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
            "Sent you a friend request. ",
            style: Get.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButtonCustom(
                  onPressed: onReject,
                  color: Get.theme.colorScheme.error,
                  label: "Deny",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  onPressed: onAccept,
                  label: "Accept",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
