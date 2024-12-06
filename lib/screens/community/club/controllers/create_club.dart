import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/Services/upload.dart';
import 'package:image_picker/image_picker.dart';

class CreateClubController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  RxString imageId = RxString('');
  RxBool isPrivate = RxBool(true);
  RxString selectedImage = RxString('');
  RxBool isLoading = RxBool(false);
  RxBool isUploading = RxBool(false);
  // Services
  final clubService = Get.find<ClubsService>();
  final uploadService = Get.find<UploadService>();

  //setters
  setIsPrivate(bool value) {
    isPrivate.value = value;
  }

  selectImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (image != null) {
      selectedImage.value = image.path;
      isUploading.value = true;
      final upload = await uploadService.uploadImage(image.path);
      if (upload.isNotEmpty) {
        imageId.value = upload;
      }
      isUploading.value = false;
    }
  }

  createClub() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await clubService.createClub(
        name: nameController.text,
        description: descriptionController.text,
        imageId: imageId.value,
        isPrivate: isPrivate.value,
      );
      isLoading.value = false;
      clearForm();
    }
  }

  clearForm() {
    nameController.clear();
    descriptionController.clear();
    imageId.value = '';
  }

  bool creationInProgress() {
    // Check if user has started filling the form but hasn't completed all fields
    bool hasStartedFilling = nameController.text.isNotEmpty ||
        descriptionController.text.isNotEmpty ||
        imageId.value.isNotEmpty;

    return hasStartedFilling;
  }
}
