import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'res/getx_localization/languages.dart';
import 'res/routes/routes.dart';
import 'res/themes/app_theme.dart';
import 'view_models/controller/app_view_models.dart';
import 'view_models/controller/theme/font_controller.dart';
import 'view_models/controller/theme/language_controller.dart';
import 'view_models/controller/theme/theme_controller.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  Get.put(AppInfoController());
  Get.put(ThemeController());
  Get.put(FontController());
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final fontController = Get.find<FontController>();
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(fontController.currentFont.value),
        darkTheme: AppTheme.darkTheme(fontController.currentFont.value),
        themeMode:
            themeController.themeMode.value, // o gestionado con otro controller
        title: 'App PROFE',
        translations: Languages(),
        locale: langController.currentLocale.value,
        fallbackLocale: const Locale('es', 'BO'),
        getPages: AppRoutes.appRoutes(),
        //  ↓↓↓ AGREGA ESTO ↓↓↓
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'), // Español
          Locale('es', 'BO'), // Español (Bolivia), si prefieres
          Locale('en', 'US'), // Inglés como fallback
        ],
      );
    });
  }
}