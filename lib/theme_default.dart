import 'package:flutter/material.dart';
import 'package:movement_reminder/theme_notifier.dart';

class UICustomLightColors {
  static const Color primary = Color.fromARGB(255, 20, 15, 9);
  static const Color secondary = Color.fromARGB(255, 166, 205, 255);
  static const Color background = Color.fromARGB(255, 255, 240, 245);
  static const Color grayText = Color.fromARGB(255, 172, 179, 188);
  static const Color white = Color.fromARGB(255, 255, 233, 244);
}

class UICustomDarkColors {
  static const Color primary = Color.fromARGB(255, 255, 254, 254);
  static const Color secondary = Color.fromARGB(255, 0, 55, 96);
  static const Color background = Color.fromARGB(255, 30, 100, 180);

  static const Color gray = Color.fromARGB(255, 46, 46, 46);
  static const Color white = Color.fromARGB(255, 255, 233, 244);
  static const Color danger = Color.fromARGB(255, 208, 77, 77);
}

ThemeData buildLightTheme(ThemeNotifier themeNotifier) {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    dividerColor: UICustomLightColors.primary,
    brightness: Brightness.light,
    primaryColor: UICustomLightColors.primary,
    scaffoldBackgroundColor: UICustomLightColors.background,
    colorScheme: const ColorScheme.light(
      primary: UICustomLightColors.primary,
      secondary: UICustomLightColors.secondary,
      surface: UICustomLightColors.secondary,
      onPrimary: UICustomLightColors.secondary,
      error: Color(0xFF990000),
    ),
  );
}

ThemeData buildDarkTheme(ThemeNotifier themeNotifier) {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    dividerColor: UICustomDarkColors.primary,
    brightness: Brightness.dark,
    primaryColor: UICustomDarkColors.primary,
    scaffoldBackgroundColor: UICustomDarkColors.background,
    colorScheme: const ColorScheme.dark(
      primary: UICustomDarkColors.primary,
      secondary: UICustomDarkColors.secondary,
      surface: UICustomDarkColors.secondary,
      error: UICustomDarkColors.danger,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: UICustomDarkColors.primary,
      displayColor: UICustomDarkColors.primary,
    ),
  );
}

class UICustomLayout {
  static const double paddingSM = 10.0;
  static const double paddingXS = 5.0;
}

InputDecoration getInputFieldBaseDecorationLight() {
  return const InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: UICustomLayout.paddingXS,
      horizontal: UICustomLayout.paddingSM,
    ),
    hintStyle: TextStyle(color: UICustomLightColors.secondary),
    labelStyle: TextStyle(color: UICustomLightColors.secondary),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomLightColors.secondary),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomLightColors.primary),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomLightColors.secondary),
    ),
    fillColor: UICustomLightColors.white,
    filled: true,
  );
}

InputDecoration getInputFieldBaseDecorationDark() {
  return const InputDecoration(
    contentPadding: EdgeInsets.all(8.0),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomDarkColors.gray),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomDarkColors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: UICustomDarkColors.gray),
    ),
    fillColor: UICustomDarkColors.primary,
    filled: true,
  );
}

InputDecoration getInputFieldBaseDecorationTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? getInputFieldBaseDecorationDark()
      : getInputFieldBaseDecorationLight();
}
