import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/utils/functions.dart';

class HabbitCard extends StatefulWidget {
  final Habit habit;
  final Function(bool) onCompleted;
  const HabbitCard({
    super.key,
    required this.habit,
    required this.onCompleted,
  });

  @override
  State<HabbitCard> createState() => _HabbitCardState();
}

class _HabbitCardState extends State<HabbitCard> {
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    isCompleted = widget.habit.isCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        splashColor: Get.theme.colorScheme.primary,
        onTap: () {
          Get.toNamed('/habit', arguments: {'habit': widget.habit});
        },
        onLongPress: () {
          widget.onCompleted(!isCompleted);
          setState(() {
            isCompleted = !isCompleted;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.habit.color.withOpacity(0.7),
                Get.theme.colorScheme.primary.withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${dayFromDate(widget.habit.nextDue)} , ${timeFromDate(widget.habit.nextDue)}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Get.theme.colorScheme.surface,
                        ),
                        child: Text(
                          widget.habit.rate,
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.habit.streak} 🔥",
                        style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isCompleted,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (bool? value) {
                      setState(() {
                        isCompleted = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          widget.habit.icon,
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.habit.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Get.theme.colorScheme.onPrimary,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "5 minutes",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                ],
              ),
              if (widget.habit.isDelayed())
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Missed! Complete now to keep streak",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
