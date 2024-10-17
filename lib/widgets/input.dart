import 'package:flutter/material.dart';
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
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      helperMaxLines: 2,
      suffixIcon: suffixIcon,
      helperStyle: const TextStyle(
        fontSize: 10,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10,
      ),
      fillColor: cardColor,
      filled: true,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      focusColor: Colors.grey[200],

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
