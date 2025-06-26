import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/theme/theme_controller.dart';

class ThemeModeSelectorWidget extends StatelessWidget {
  const ThemeModeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      final selectedMode = themeController.themeMode.value;

      Widget buildChip({
        required ThemeMode mode,
        required IconData icon,
        required String label,
      }) {
        final isSelected = selectedMode == mode;

        return RawChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          backgroundColor: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : colorScheme.surface.withValues(alpha: 0.3),
          side: BorderSide(
            color: isSelected ? colorScheme.primary : colorScheme.outline.withValues(alpha: 0.4),
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          onPressed: () {
            switch (mode) {
              case ThemeMode.light:
                themeController.setLightMode();
                break;
              case ThemeMode.dark:
                themeController.setDarkMode();
                break;
              case ThemeMode.system:
                themeController.setSystemMode();
                break;
            }
          },
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona el tema',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: [
              buildChip(
                mode: ThemeMode.light,
                icon: Icons.wb_sunny,
                label: 'Claro',
              ),
              buildChip(
                mode: ThemeMode.dark,
                icon: Icons.nightlight_round,
                label: 'Oscuro',
              ),
              buildChip(
                mode: ThemeMode.system,
                icon: Icons.settings,
                label: 'Sistema',
              ),
            ],
          ),
        ],
      );
    });
  }
}
