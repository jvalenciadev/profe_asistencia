import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/theme/language_controller.dart';

class LanguageSelectorWidget extends StatelessWidget {
  final List<Map<String, String>> languages = [
    {'label': 'language_es', 'code': 'es', 'country': 'BO'},
    {'label': 'language_en', 'code': 'en', 'country': 'US'},
    {'label': 'language_ur', 'code': 'ur', 'country': 'PK'},
  ];

  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(() {
      final selectedLocale = langController.currentLocale;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'change_language'.tr,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: languages.map((lang) {
              final isSelected =
                  selectedLocale.value.languageCode == lang['code'] &&
                  selectedLocale.value.countryCode == lang['country'];

              return RawChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.language,
                      size: 18,
                      color: isSelected
                          ? colorScheme.primary
                          : theme.iconTheme.color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      lang['label']!.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isSelected
                            ? colorScheme.primary
                            : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                backgroundColor: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : theme.chipTheme.backgroundColor,
                side: BorderSide(
                  color: isSelected
                      ? colorScheme.primary
                      : theme.dividerColor.withAlpha(90),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                onPressed: () {
                  langController.changeLanguage(
                      lang['code']!, lang['country']!);
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
