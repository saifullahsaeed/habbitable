import 'package:flutter/material.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/widgets/habitcard.dart';

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
          tabs: const [
            Tab(text: 'Habits'),
            Tab(text: 'Goals'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
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
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    for (int i = 0; i < 100; i++) Text('Goal $i'),
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
