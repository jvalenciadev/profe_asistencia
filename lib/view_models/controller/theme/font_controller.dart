import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/fonts/app_fonts.dart';

class FontController extends GetxController {
  static const String _key = 'app_font';

  var currentFont = AppFonts.montserrat.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFont();
  }

  Future<void> _loadFont() async {
    final prefs = await SharedPreferences.getInstance();
    final font = prefs.getString(_key) ?? AppFonts.montserrat;
    currentFont.value = font;
  }

  Future<void> setFont(String fontFamily) async {
    currentFont.value = fontFamily;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, fontFamily);
  }
}
