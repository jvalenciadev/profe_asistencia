import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/fonts/app_fonts.dart';
import '../view_models/controller/theme/font_controller.dart';

class FontSelectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontController = Get.find<FontController>();
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      return Column(
        children: [
          Text(
            'Fuente actual: ${fontController.currentFont.value}',
            style: TextStyle(fontFamily: fontController.currentFont.value),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:
                    () => fontController.setFont(AppFonts.schylerRegular),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: textTheme.labelLarge,
                ),
                child: const Text('Schyler'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => fontController.setFont(AppFonts.montserrat),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: textTheme.labelLarge,
                ),
                child: const Text('Montserrat'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => fontController.setFont(AppFonts.mina),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: textTheme.labelLarge,
                ),
                child: const Text('Mina'),
              ),
            ],
          ),
        ],
      );
    });
  }
}
