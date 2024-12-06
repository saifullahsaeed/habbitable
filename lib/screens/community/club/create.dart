import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/create_club.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class CreateClubScreen extends GetView<CreateClubController> {
  const CreateClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (controller.creationInProgress()) {
          final bool shouldPop = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Attention"),
                  content: const Text(
                      "Your progress will be lost if you leave this page."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        "Leave",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ) ??
              false;

          if (shouldPop) {
            Get.back();
          }
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: "Create Club",
          showNotifications: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Obx(
                () => Column(
                  children: [
                    GestureDetector(
                      onTap: controller.selectImage,
                      child: controller.selectedImage.value.isEmpty
                          ? Container(
                              width: Get.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      size: 30,
                                      color: Colors.grey[500],
                                    ),
                                    Text(
                                      "Add Image",
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              width: Get.width,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(controller.selectedImage.value),
                                    )),
                              ),
                            ),
                    ),
                    controller.isUploading.value
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: LinearProgressIndicator(),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 16),
                    buildInput(
                      label: "Name",
                      hint: "Enter the name of the club",
                      maxLength: 40,
                      controller: controller.nameController,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter a name" : null,
                      context: context,
                    ),
                    SizedBox(height: 16),
                    buildInput(
                      label: "Description",
                      hint: "Enter the description of the club",
                      controller: controller.descriptionController,
                      context: context,
                      maxLines: 5,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: controller.isPrivate.value,
                          onChanged: (value) =>
                              controller.setIsPrivate(value ?? false),
                        ),
                        Text(
                          "Is Private Club",
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Text(
                      "Private clubs are only accessible to invited members. By unchecking this, you make the club public and accessible to all users on the platform.",
                      style: TextStyle(
                        fontSize: 10,
                        color: Get.theme.colorScheme.outlineVariant,
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: Get.width,
                      child: MainButton(
                        label: "Create Club",
                        disabled: controller.isLoading.value,
                        onPressed: () async {
                          await controller.createClub();
                          Get.offAndToNamed('/community');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
