import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  static const String _langCodeKey = 'language_code';
  static const String _countryCodeKey = 'country_code';

  var currentLocale = const Locale('es', 'BO').obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocaleFromPrefs();
  }

  void changeLanguage(String languageCode, String countryCode) async {
    final locale = Locale(languageCode, countryCode);
    currentLocale.value = locale;
    Get.updateLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langCodeKey, languageCode);
    await prefs.setString(_countryCodeKey, countryCode);
  }

  Future<void> _loadLocaleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_langCodeKey);
    final countryCode = prefs.getString(_countryCodeKey);

    if (languageCode != null && countryCode != null) {
      final locale = Locale(languageCode, countryCode);
      currentLocale.value = locale;
      Get.updateLocale(locale);
    }
  }
}
