import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/controllers/search_controller.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  SearchUserController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Search User",
        showNotifications: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              showUserSearchField(
                context,
                "Name or Email",
                "search with name or email to find a user you will not be able to see blocked users or users you have blocked",
                (search) async {
                  return await controller.searchUser(search);
                },
                (user) {},
                (user) async {
                  return await controller.sendFriendRequest(user);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
