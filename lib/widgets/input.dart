import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/utils/consts.dart';

TextFormField buildInput({
  required String label,
  required String hint,
  String? helper,
  TextInputType inputType = TextInputType.text,
  required TextEditingController controller,
  bool isPassword = false,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  required BuildContext context,
  void Function(String)? onChanged,
  int? maxLines,
  int? maxLength,
}) {
  return TextFormField(
    keyboardType: inputType,
    controller: controller,
    obscureText: isPassword,
    onTapOutside: (focus) {
      FocusScope.of(context).unfocus();
    },
    validator: validator,
    //change focus scope to next field
    onFieldSubmitted: (value) {
      FocusScope.of(context).unfocus();
    },
    onChanged: onChanged,
    maxLines: maxLines ?? 1,
    //character limit
    maxLength: maxLength,
    style: Get.theme.textTheme.bodySmall,
    //hide max length counter
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      helperMaxLines: 2,
      hintMaxLines: 1,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      alignLabelWithHint: true,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 20,
      ),

      //max length style
      counterText: '',
      helperStyle: Get.theme.textTheme.bodySmall,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
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
        color: Get.theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      focusColor: Get.theme.colorScheme.onSurface.withOpacity(0.5),

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
  );
}

DropdownButtonFormField<String> buildDropdown({
  required String label,
  required String hint,
  String? helper,
  required List<String> items,
  required String? value,
  required void Function(String?) onChanged,
  String? Function(String?)? validator,
  required BuildContext context,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    onChanged: onChanged,
    validator: validator,
    icon: const Icon(CupertinoIcons.chevron_down),
    iconSize: 20,
    elevation: 0,
    style: Get.theme.textTheme.bodySmall,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      helperMaxLines: 2,
      hintMaxLines: 1,
      helperStyle: const TextStyle(
        fontSize: 10,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
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
        color: Get.theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      focusColor: Get.theme.colorScheme.onSurface.withOpacity(0.5),
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
    items: items.map((String item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item),
      );
    }).toList(),
  );
}

//time picker widget

showTimePickerField(
  BuildContext context,
  String label,
  Function(TimeOfDay) onTimeSelected,
) {
  TimeOfDay initialTime = TimeOfDay(hour: DateTime.now().hour, minute: 0);
  return InkWell(
    onTap: () => showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) {
      if (value != null) {
        onTimeSelected(value);
      }
    }),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Get.theme.cardColor,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Get.theme.textTheme.bodySmall,
      ),
    ),
  );
}
