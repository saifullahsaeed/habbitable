import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/profile/controllers/editprofile_controller.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Get.textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: controller.formKey,
            child: Obx(
              () => Column(
                children: [
                  Center(
                    child: controller.user.value.avatar != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              controller.user.value.avatar!.url,
                            ),
                          )
                        : InitialsImagePlaceholder(
                            name: controller.user.value.name,
                            radius: 50,
                          ),
                  ),
                  Center(
                    child: MainButton(
                      label: 'Change Icon',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Select Image Source',
                                  style: Get.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  tileColor: Get.theme.cardColor,
                                  leading: Icon(
                                    Icons.image,
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  title: Text(
                                    'Gallery',
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  onTap: () async {
                                    final path = await controller.pickAvatar(
                                        type: 'gallery');
                                    await controller.uploadAvatar(path);
                                  },
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  tileColor: Get.theme.cardColor,
                                  leading: Icon(
                                    Icons.camera,
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  title: Text(
                                    'Camera',
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  onTap: () async {
                                    final path = await controller.pickAvatar(
                                        type: 'camera');
                                    await controller.uploadAvatar(path);
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      style: 'secondary',
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildInput(
                    context: context,
                    label: 'Name',
                    hint: 'Enter your name',
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 10),
                  buildInput(
                    context: context,
                    label: 'Age',
                    hint: 'Enter your age',
                    controller: controller.ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (int.tryParse(value) == null) {
                        return 'Age must be a number';
                      }
                      if (int.parse(value) < 18) {
                        return 'You must be at least 18 years old';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width,
                    child: MainButton(
                      label: 'Save',
                      icon: Icons.save_outlined,
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        controller.isLoading.value = true;
                        if (controller.formKey.currentState!.validate()) {
                          await Future.delayed(const Duration(seconds: 2));
                        }
                        controller.isLoading.value = false;
                      },
                      style: 'primary',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
