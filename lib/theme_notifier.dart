import 'package:flutter/material.dart';
import 'package:movement_reminder/theme_default.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _lightMode = buildLightTheme(this);
    _darkMode = buildDarkTheme(this);
    _themeData = _lightMode;
  }

  late final ThemeData _lightMode;
  late final ThemeData _darkMode;
  late ThemeData _themeData;

  ThemeData get lightTheme => _lightMode;
  ThemeData get darkTheme => _darkMode;
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == _darkMode;

  void toggleTheme() {
    _themeData = isDarkMode ? _lightMode : _darkMode;
    notifyListeners();
  }
}
