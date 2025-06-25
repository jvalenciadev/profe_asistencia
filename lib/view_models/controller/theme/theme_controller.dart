import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _prefKey = 'theme_mode';

  // Observa el modo de tema actual
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  // Cargar tema guardado
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_prefKey) ?? ThemeMode.system.index;
    themeMode.value = ThemeMode.values[themeIndex];
    Get.changeThemeMode(themeMode.value);
  }

  // Guardar tema actual
  Future<void> _saveThemeToPrefs(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefKey, mode.index);
  }

  void setLightMode() {
    themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
    _saveThemeToPrefs(ThemeMode.light);
  }

  void setDarkMode() {
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
    _saveThemeToPrefs(ThemeMode.dark);
  }

  void setSystemMode() {
    themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
    _saveThemeToPrefs(ThemeMode.system);
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  bool get isSystemMode => themeMode.value == ThemeMode.system;
  bool get isLightMode => themeMode.value == ThemeMode.light;
}
