import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/fonts/app_fonts.dart';
import '../view_models/controller/theme/font_controller.dart';

class FontSelectorWidget extends StatelessWidget {
  final List<Map<String, String>> fonts = [
    {'label': 'Montserrat', 'value': AppFonts.montserrat},
    {'label': 'Roboto', 'value': AppFonts.roboto},
    {'label': 'Mina', 'value': AppFonts.mina},
    {'label': 'Bellota', 'value': AppFonts.bellota},
    {'label': 'Work Sans', 'value': AppFonts.workSans},
    {'label': 'Open Sans', 'value': AppFonts.openSans},
    {'label': 'Nunito', 'value': AppFonts.nunito},
    {'label': 'Lato', 'value': AppFonts.lato},
  ];

  @override
  Widget build(BuildContext context) {
    final fontController = Get.find<FontController>();
    final currentFont = fontController.currentFont;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fuente actual',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),

          // Lista de fuentes como Chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: fonts.map((font) {
              final isSelected = font['value'] == currentFont.value;
              return RawChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.font_download_outlined,
                      size: 18,
                      color: isSelected
                          ? colorScheme.primary
                          : theme.iconTheme.color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      font['label']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: font['value'],
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
                      : theme.dividerColor.withAlpha(100),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                onPressed: () {
                  fontController.setFont(font['value']!);
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
