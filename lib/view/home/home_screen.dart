import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/font_select.dart';
import '../../widgets/lenguaje_select.dart';
import '../../widgets/modo_select.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecciona el modo de tema:',
              style: textTheme.headlineMedium,
            ),
            Text('Estilo: headlineMedium', style: textTheme.labelSmall,),
            const SizedBox(height: 20),
            ThemeModeSelectorWidget(),
            const SizedBox(height: 24),
            FontSelectorWidget(),
            LanguageSelectorWidget(),
            Text(
              'displayLarge - Título principal grande',
              style: textTheme.displayLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'displayMedium - Título principal mediano',
              style: textTheme.displayMedium,
            ),
            const SizedBox(height: 12),
            Text('change_language'.tr, style: textTheme.displaySmall),
            const SizedBox(height: 24),

            Text(
              'headlineLarge - Encabezado grande',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'headlineMedium - Encabezado medio',
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text('change_language'.tr, style: textTheme.headlineSmall),
            const SizedBox(height: 24),

            Text('titleLarge - Título grande', style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('titleMedium - Título medio', style: textTheme.titleMedium),
            const SizedBox(height: 12),
            Text('titleSmall - Título pequeño', style: textTheme.titleSmall),
            const SizedBox(height: 24),

            Text(
              'bodyLarge - Cuerpo de texto grande (párrafo)',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'bodyMedium - Cuerpo de texto medio',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'bodySmall - Cuerpo de texto pequeño',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 24),

            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(8),
              child: Text(
                'labelLarge - Etiqueta grande',
                style: textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'labelMedium - Etiqueta mediana',
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: 12),
            Text('labelSmall - Etiqueta pequeña', style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
