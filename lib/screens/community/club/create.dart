import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/catagory.dart';
import 'package:habbitable/screens/community/club/controllers/create_club.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class CreateClubScreen extends GetView<CreateClubController> {
  const CreateClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //dropdown for catagory
                  DropdownButtonFormField<Catagory>(
                    value: null,
                    decoration: InputDecoration(
                      hintText: "Select the catagory of the club",
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      alignLabelWithHint: false,

                      helperStyle: Get.theme.textTheme.bodySmall,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, // Added vertical padding
                        horizontal: 10,
                      ),
                      fillColor: Get.theme.cardColor,
                      filled: true,
                      labelStyle: TextStyle(
                        color: Get.theme.textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      hintStyle: TextStyle(
                        color: Get.theme.textTheme.bodyMedium!.color!
                            .withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      focusColor:
                          Get.theme.colorScheme.onSurface.withOpacity(0.5),

                      //no border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(6),
                    items: controller.catagories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedCatagory.value = value;
                      }
                    },
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
    );
  }
}
