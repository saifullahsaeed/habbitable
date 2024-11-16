import 'package:flutter/material.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/models/profile.dart';
import 'package:habbitable/repos/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final int userId;
  ProfileController({required this.userId});
  final GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  final TextEditingController reportController = TextEditingController();
  Rx<Profile> profile = Profile.empty().obs;
  late int myId;
  final UserRepository userRepository = UserRepository();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    myId = authService.currentUser.id;
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final response = await userRepository.getProfile(userId);
    if (response.statusCode == 200) {
      profile.value = Profile.fromJson(response.data);
    }
    isLoading.value = false;
  }

  bool get isMyProfile => myId == userId;

  void sendRequest() {
    profile.value.requestSent = true;
    userRepository.sendRequest(userId).then((value) {
      if (value.statusCode != 200) {
        profile.value.requestSent = false;
      }
    });
  }

  void rejectRequest() {
    profile.value.requestReceived = false;
    userRepository.rejectRequest(userId).then((value) {
      if (value.statusCode != 200) {
        profile.value.requestReceived = true;
      }
    });
  }

  void acceptRequest() {
    profile.value.isFriend = true;
    profile.value.requestReceived = false;
    userRepository.acceptRequest(userId).then((value) {
      if (value.statusCode != 200) {
        profile.value.isFriend = false;
        profile.value.requestReceived = true;
      }
    });
  }
}
