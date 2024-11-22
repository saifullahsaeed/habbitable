import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:line_icons/line_icons.dart';

class ProfileTabs extends StatefulWidget {
  final List<Habit> habits;
  const ProfileTabs({super.key, required this.habits});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          dividerHeight: 0,
          tabAlignment: TabAlignment.fill,
          indicator: BoxDecoration(
            border: Border.all(
              color: Get.theme.colorScheme.primary.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(10),
            color: Get.theme.colorScheme.primary.withOpacity(0.1),
          ),
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.alternateFire),
                  SizedBox(width: 5),
                  Text('Habits'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.medal),
                  SizedBox(width: 5),
                  Text('Achievements'),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              if (widget.habits.isEmpty)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LineIcons.alternateFire, size: 50),
                        Text('No habits available for this user'),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: widget.habits.length,
                    itemBuilder: (context, index) => HabbitCard(
                      habit: widget.habits[index],
                      disabled: true,
                      onCompleted: (completed) {},
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LineIcons.medal, size: 50),
                    Text('No achievements yet'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
