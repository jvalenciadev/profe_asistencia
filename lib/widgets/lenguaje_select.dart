import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/theme/language_controller.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  final List<Map<String, String>> languages = const [
    {'label': 'language_es', 'code': 'es', 'country': 'BO'},
    {'label': 'language_en', 'code': 'en', 'country': 'US'},
    {'label': 'language_ur', 'code': 'ur', 'country': 'PK'},
  ];

  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      final selectedLocale = langController.currentLocale;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Idioma del sistema',
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Selecciona el idioma de preferencia',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: languages.map((lang) {
              final isSelected =
                  selectedLocale.value.languageCode == lang['code'] &&
                  selectedLocale.value.countryCode == lang['country'];

              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.language,
                      size: 18,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      lang['label']!.tr,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                selected: false,
                selectedColor: colorScheme.primary.withValues(alpha: 0.1),
                backgroundColor: colorScheme.surface.withValues(alpha: 0.2),
                side: BorderSide(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.outline.withValues(alpha: 0.3),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onSelected: (_) {
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
