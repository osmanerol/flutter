import 'package:flutter/material.dart';

class Theme with ChangeNotifier {
  static bool _dark=false;

  void changeTheme() {
    _dark=!_dark;
    notifyListeners();
  }

  ThemeMode mode() {
    return _dark ? ThemeMode.dark : ThemeMode.light;
  }

}