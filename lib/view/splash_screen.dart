import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../res/assets/image_assets.dart';
import '../../view_models/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashScreen = SplashServices();
  Map<String, String> appInfo = {
    "appName": "Cargando...",
    "appLogo": "",
    "appVersion": "",
  };

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchAppInfo();
  }

  void _fetchAppInfo() {
    setState(() => hasError = false);
    splashScreen.isLogin(
      (data) {
        setState(() {
          appInfo = data;
        });
      },
      onError: () {
        setState(() => hasError = true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surface.withOpacity(0.9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeIn(
            duration: const Duration(milliseconds: 900),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 80),
                hasError
                    ? _buildErrorMessage(textTheme, colorScheme)
                    : _buildAppInfo(textTheme, colorScheme),
                const SizedBox(height: 20),
                hasError
                    ? _buildRetryButton(colorScheme, textTheme)
                    : _buildLoadingIndicator(textTheme, colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        ImageAssets.logoProfe,
        width: 260,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Icon(
              Icons.image_not_supported,
              size: 100,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildAppInfo(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        _buildInfoRow(
          'version_label'.tr,
          appInfo['appVersion'],
          textTheme,
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String? value,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            value ?? 'loading'.tr,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        CircularProgressIndicator(color: colorScheme.primary),
        const SizedBox(height: 10),
        Text(
          'loading'.tr,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildRetryButton(ColorScheme colorScheme, TextTheme textTheme) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _fetchAppInfo,
      icon: const Icon(FontAwesomeIcons.arrowsRotate),
      label: Text('retry'.tr, style: textTheme.labelLarge),
    );
  }

  Widget _buildErrorMessage(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        const Icon(Icons.wifi_off, size: 60, color: Colors.redAccent),
        const SizedBox(height: 10),
        Text(
          'no_connection_title'.tr,
          style: textTheme.titleMedium?.copyWith(color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          'no_connection_subtitle'.tr,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
