import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/new_post_controller.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:line_icons/line_icons.dart';

class NewPostScreen extends GetView<NewPostController> {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: MainAppBar(
                title: '',
                showNotifications: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      controller.toggleEditMode();
                    },
                    icon: Icon(Icons.visibility_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addPost();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Post',
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            LineIcons.paperPlane,
                            size: 14,
                            color: Get.theme.colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          bottom: 60, top: 70), // Leave space for toolbar
                      child: controller.isEditing.value
                          ? TextField(
                              controller: controller.markdownController,
                              focusNode: controller.focusNode,
                              maxLines: null,
                              autofocus: true,
                              maxLength: 1000,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Write something here...',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            )
                          : Markdown(
                              data: controller.markdownController.text,
                              selectable: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              styleSheet: MarkdownStyleSheet(
                                p: Get.textTheme.bodyMedium,
                              ),
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.cardColor,
                            blurRadius: 2,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Get.theme.colorScheme.surface,
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.clubDetails.club.image?.url ?? "",
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            controller.clubDetails.club.name,
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Toolbar Above Keyboard
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.cardColor,
                            blurRadius: 2,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FocusScope(
                            canRequestFocus: false,
                            child: DropdownButton(
                              value: 'normal',
                              style: Get.textTheme.bodyMedium,
                              underline: SizedBox.shrink(),
                              icon: Icon(Icons.arrow_drop_down),
                              borderRadius: BorderRadius.circular(6),
                              focusNode: FocusNode(
                                skipTraversal: true,
                                canRequestFocus: false,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'normal',
                                  child: Text('Normal'),
                                ),
                                DropdownMenuItem(
                                  value: 'large',
                                  child: Text('Large'),
                                ),
                                DropdownMenuItem(
                                  value: 'huge',
                                  child: Text('Huge'),
                                ),
                              ],
                              onChanged: (value) {
                                controller.toggleMarkdownTextSize(
                                    size: value ?? 'normal');
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.toggleMarkdownStyle(style: '**');
                            },
                            icon: Icon(Icons.format_bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.format_italic),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.code),
                          ),
                          // Add more formatting buttons as needed
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
