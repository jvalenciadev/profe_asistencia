import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/theme/theme_controller.dart';

class ThemeModeSelectorWidget extends StatelessWidget {
  const ThemeModeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
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
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium?.fontFamily,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).chipTheme.backgroundColor,
          side: BorderSide(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
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
