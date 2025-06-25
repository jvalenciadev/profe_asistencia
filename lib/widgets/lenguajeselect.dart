import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/theme/language_controller.dart';

class LanguageSelectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'change_language'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => langController.changeLanguage('es', 'BO'),
              child: Text('language_es'.tr),
            ),
            ElevatedButton(
              onPressed: () => langController.changeLanguage('en', 'US'),
              child: Text('language_en'.tr),
            ),
            ElevatedButton(
              onPressed: () => langController.changeLanguage('ur', 'PK'),
              child: Text('language_ur'.tr),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('email_hint'.tr),
        Text('password_hint'.tr),
        Text('login'.tr),
        Text('welcome_back'.tr, textAlign: TextAlign.center),
      ],
    );
  }
}
