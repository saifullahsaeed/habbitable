import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class HabitUsersScreen extends StatefulWidget {
  final Habit habit;
  const HabitUsersScreen({super.key, required this.habit});

  @override
  State<HabitUsersScreen> createState() => _HabitUsersScreenState();
}

class _HabitUsersScreenState extends State<HabitUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: Get.theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Owner",
              style: Get.theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              minLeadingWidth: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Get.theme.cardColor,
              leading: widget.habit.owner.avatar != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        widget.habit.owner.avatar!.url,
                      ),
                    )
                  : InitialsImagePlaceholder(
                      name: widget.habit.owner.name,
                    ),
              title: Text(
                widget.habit.owner.name,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 20,
              ),
              onTap: () {},
            ),
            SizedBox(height: 16),
            Text(
              "Members",
              style: Get.theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.habit.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    minLeadingWidth: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Get.theme.cardColor,
                    leading: widget.habit.users[index].avatar != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              widget.habit.users[index].avatar!.url,
                            ),
                          )
                        : InitialsImagePlaceholder(
                            name: widget.habit.users[index].name,
                          ),
                    title: Text(widget.habit.users[index].name),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
