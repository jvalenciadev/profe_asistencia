// Extensión del sistema de alertas para incluir botones como "Sí / No" o "Cancelar"

import 'package:flutter/material.dart';
import 'package:profe_asistencia/res/colors/app_color.dart';
import 'package:profe_asistencia/widgets/custom_alert.dart';

Future<void> showCustomConfirmationDialog(
  BuildContext context, {
  required AlertType type,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String confirmText = 'Sí',
  String cancelText = 'Cancelar',
}) async {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  Color iconColor = switch (type) {
    AlertType.success => AppColor.sentColor,
    AlertType.warning => AppColor.warningColor,
    AlertType.error => AppColor.errorColor,
    AlertType.info => AppColor.infoColor,
  };

  IconData icon = switch (type) {
    AlertType.success => Icons.check_circle_outline,
    AlertType.warning => Icons.warning_amber_rounded,
    AlertType.error => Icons.error_outline,
    AlertType.info => Icons.info_outline,
  };

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      content: Text(message, style: textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel();
          },
          child: Text(cancelText, style: TextStyle(color: colorScheme.primary)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: iconColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    ),
  );
}