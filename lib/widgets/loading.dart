import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; 
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logos/logoprofe.png',
              width: 150,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              'Cargando información...',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 60,
              height: 60,
              child: LoadingAnimationWidget.hexagonDots(
                color: colorScheme.primary,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
