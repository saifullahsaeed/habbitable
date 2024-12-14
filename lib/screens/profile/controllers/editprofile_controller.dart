import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/upload.dart';
import 'package:habbitable/models/profile.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/repos/user.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final UploadService uploadService = UploadService();
  final GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  late int userId;
  RxBool isLoading = false.obs;
  Rx<User> user = User(id: 0, name: '', email: '').obs;
  Rx<Profile> profile = Profile.empty().obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    userId = authService.currentUser.id;
    user.value = Get.arguments['user'];
    nameController.text = user.value.name;
    ageController.text = user.value.age?.toString() ?? '';
    super.onInit();
  }

  void updateProfile({
    String? name,
    int? age,
    String? gender,
    int? avatarId,
  }) {
    userRepository.updateProfile(userId, {
      'name': name ?? user.value.name,
      'age': age ?? user.value.age,
      'gender': gender ?? user.value.gender,
      'avatarId': avatarId ?? user.value.avatar?.id,
    }).then((value) {
      if (value.statusCode == 200) {
        profile.value = Profile.fromJson(value.data);
      }
    });
  }

  Future<String> pickAvatar({String type = 'gallery'}) async {
    final image = await ImagePicker().pickImage(
      source: type == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 90,
    );
    if (image != null) {
      return image.path;
    }
    throw Exception('Failed to pick image');
  }

  Future<void> uploadAvatar(String path) async {
    final id = await uploadService.uploadImage(path);
    if (id.isNotEmpty) {
      updateProfile(avatarId: int.parse(id));
    }
  }
}
