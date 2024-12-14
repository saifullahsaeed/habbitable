import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/details.dart';
import 'package:habbitable/utils/snackbar.dart';

class NewPostController extends GetxController {
  final ClubsService clubsService = Get.find<ClubsService>();
  late String clubId;
  late ClubDetails clubDetails;
  final TextEditingController markdownController = TextEditingController();
  final TextEditingController previewController = TextEditingController();
  final RxBool isEditing = true.obs;
  final FocusNode focusNode = FocusNode();
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    clubId = Get.arguments['clubId'];
    clubDetails = Get.arguments['clubDetails'];
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (isEditing.value) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
    }
  }

  void toggleMarkdownStyle({
    required String style,
  }) {
    final controller = markdownController;
    final text = controller.text;
    final selection = controller.selection;

    // Ensure the selection is valid
    if (!selection.isValid) return;

    final start = selection.start;
    final end = selection.end;

    if (start == end) {
      // No text is selected
      // Check if cursor is inside an existing style block to undo it
      final beforeCursor = text.substring(0, start);
      final afterCursor = text.substring(start);
      if (beforeCursor.endsWith(style) && afterCursor.startsWith(style)) {
        // Undo action
        controller.text =
            beforeCursor.substring(0, beforeCursor.length - style.length) +
                afterCursor.substring(style.length);
        controller.selection =
            TextSelection.collapsed(offset: start - style.length);
      } else {
        // Add symbols and place cursor in between
        controller.text = beforeCursor +
            style +
            style +
            afterCursor; // Add symbols around cursor
        controller.selection = TextSelection.collapsed(
            offset: start + style.length); // Place cursor in between
      }
    } else {
      // Text is selected
      var selectedText = text.substring(start, end);
      //strip end space
      selectedText = selectedText.trimRight();

      // Check if selected text is already wrapped with the style
      if (selectedText.startsWith(style) && selectedText.endsWith(style)) {
        // Undo the style
        controller.text = text.replaceRange(
          start,
          end,
          selectedText.substring(
              style.length, selectedText.length - style.length),
        );
        controller.selection = TextSelection(
            baseOffset: start, extentOffset: end - (2 * style.length));
      } else {
        // Apply the style
        controller.text = text.replaceRange(
          start,
          end,
          "$style$selectedText$style",
        );
        controller.selection = TextSelection(
            baseOffset: start, extentOffset: end + (2 * style.length));
      }
    }
  }

  void toggleMarkdownTextSize({
    required String size, // "normal", "large", "huge"
  }) {
    final controller = markdownController;
    final text = controller.text;
    final selection = controller.selection;

    if (!selection.isValid) return;

    final start = selection.start;
    final end = selection.end;

    final selectedText = start == end ? null : text.substring(start, end);

    // Define Markdown prefixes for sizes
    final sizePrefix = size == 'normal'
        ? ''
        : size == 'large'
            ? '## '
            : size == 'huge'
                ? '# '
                : '';

    if (selectedText != null) {
      // If text is selected
      final currentPrefix = getCurrentPrefix(selectedText);

      if (size == 'normal') {
        // Remove any size prefix
        final cleanedText = removeSizePrefix(selectedText, currentPrefix);
        controller.text = text.replaceRange(start, end, cleanedText);
        controller.selection = TextSelection(
            baseOffset: start, extentOffset: start + cleanedText.length);
      } else {
        // Add or toggle the size prefix
        final updatedText = currentPrefix == sizePrefix
            ? removeSizePrefix(selectedText, currentPrefix)
            : sizePrefix + removeSizePrefix(selectedText, currentPrefix);

        controller.text = text.replaceRange(start, end, updatedText);
        controller.selection = TextSelection(
            baseOffset: start, extentOffset: start + updatedText.length);
      }
    } else {
      // No selection: Handle prefix at cursor position
      final beforeCursor = text.substring(0, start);
      final afterCursor = text.substring(start);
      final currentPrefix = getCurrentPrefix(beforeCursor);

      if (size == 'normal' || currentPrefix == sizePrefix) {
        // Remove size prefix
        final updatedText =
            removeSizePrefix(beforeCursor, currentPrefix) + afterCursor;
        controller.text = updatedText;
        controller.selection =
            TextSelection.collapsed(offset: start - currentPrefix.length);
      } else {
        // Add size prefix
        final updatedText = sizePrefix + beforeCursor.trimLeft() + afterCursor;
        controller.text = updatedText;
        controller.selection =
            TextSelection.collapsed(offset: start + sizePrefix.length);
      }
    }
  }

// Helper to determine current prefix
  String getCurrentPrefix(String text) {
    if (text.startsWith('## ')) return '## ';
    if (text.startsWith('# ')) return '# ';
    return '';
  }

// Helper to remove prefix
  String removeSizePrefix(String text, String prefix) {
    return text.startsWith(prefix) ? text.substring(prefix.length) : text;
  }

  void addPost() async {
    isLoading.value = true;
    final res = await clubsService.addPost(clubId, {
      'content': markdownController.text,
    });
    isLoading.value = false;
    if (res == 201) {
      Get.back();
    } else {
      showSnackBar(
        title: 'Error',
        message: 'Failed to add post',
        type: 'error',
      );
    }
  }
}
