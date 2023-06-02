import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';

  saveTheme(bool isDarkMode) {
    box.write(key, isDarkMode);
  }

  bool loadTheme() {
    return box.read<bool>(key) ?? false;
  }

  ThemeMode get theme {
    return loadTheme() ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    Get.changeThemeMode(loadTheme() ? ThemeMode.light : ThemeMode.dark);
    saveTheme(!loadTheme());
  }
}
