import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/fonts/app_fonts.dart';
import '../view_models/controller/theme/font_controller.dart';

class FontSelectorWidget extends StatelessWidget {
  const FontSelectorWidget({super.key});

  static const List<Map<String, String>> fonts = [
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Future<String?> _showFontPicker(
      BuildContext context,
      FontController fontController,
      List<Map<String, String>> fonts,
      ColorScheme colorScheme,
      TextTheme textTheme,
    ) {
      return showDialog<String>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black54, // fondo oscuro semitransparente
        builder: (context) {
          final currentFont = fontController.currentFont.value;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: colorScheme.surface,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 380),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header con título y botón cerrar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Selecciona una fuente',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.close_rounded,
                              color: colorScheme.onSurfaceVariant,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  // Lista de fuentes
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: fonts.length,
                      separatorBuilder:
                          (_, __) => Divider(
                            color: colorScheme.outline.withValues(alpha:0.1),
                            height: 1,
                          ),
                      itemBuilder: (context, index) {
                        final font = fonts[index];
                        final isSelected = font['value'] == currentFont;

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          title: Text(
                            font['label']!,
                            style: textTheme.headlineSmall?.copyWith(
                              fontFamily: font['value'],
                              fontWeight: FontWeight.w700,
                              color:
                                  isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                          trailing:
                              isSelected
                                  ? Icon(
                                    Icons.check_circle_rounded,
                                    color: colorScheme.primary,
                                    size: 20,
                                  )
                                  : Icon(
                                    Icons.circle_outlined,
                                    color: colorScheme.outline,
                                  ),
                          onTap: () => Navigator.pop(context, font['value']),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> _openFontPicker(BuildContext context) async {
      final fontController = Get.find<FontController>();
      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      final selectedFont = await _showFontPicker(
        context,
        fontController,
        fonts,
        colorScheme,
        textTheme,
      );

      if (selectedFont != null &&
          selectedFont != fontController.currentFont.value) {
        fontController.setFont(selectedFont);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fuente del sistema',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Elige una fuente para toda la aplicación',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => _openFontPicker(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha:0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorScheme.onSurface),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final currentFont = fontController.currentFont.value;
                  final fontLabel =
                      fonts.firstWhere(
                        (f) => f['value'] == currentFont,
                        orElse: () => fonts[0],
                      )['label']!;
                  return Text(
                    fontLabel,
                    style: textTheme.bodyLarge?.copyWith(
                      fontFamily: currentFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                  );
                }),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
