import 'package:flutter/material.dart';
import 'package:habbitable/utils/consts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    error: errorColor,
    onError: onSecondaryColor,
    surface: surfaceLight,
    onSurface: Colors.black,
  ),
  primaryColor: primaryColor,
  primaryColorDark: primaryColor,
  fontFamily: fontFamily,
  useMaterial3: true,
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(onPrimaryColor),
      iconColor: WidgetStatePropertyAll(onPrimaryColor),
    ),
  ),
  cardColor: cardColor,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
      gapPadding: 2,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: primaryColor,
      ),
      gapPadding: 2,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: errorColor,
      ),
      gapPadding: 2,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: errorColor,
      ),
      gapPadding: 2,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    error: errorColor,
    onError: onSecondaryColor,
    surface: surfaceDark,
    onSurface: Colors.white,
  ),
  fontFamily: fontFamily,
  useMaterial3: true,
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(onPrimaryColor),
      iconColor: WidgetStatePropertyAll(onPrimaryColor),
    ),
  ),
  cardColor: cardColorDark,
);
