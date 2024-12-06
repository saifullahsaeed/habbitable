import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/utils/functions.dart';

class ClubTile extends StatelessWidget {
  final Club club;
  const ClubTile({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/club/${club.id}/details'),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  club.image != null ? NetworkImage(club.image!.url) : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                club.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (club.isPrivate)
                              const Icon(
                                Icons.lock,
                                size: 15,
                              ),
                            if (club.isVerified)
                              const Icon(
                                Icons.verified,
                                size: 15,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ),
                      Text(
                        timeFromDate(club.createdAt),
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    club.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
