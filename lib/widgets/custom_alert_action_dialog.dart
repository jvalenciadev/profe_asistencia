import 'package:flutter/material.dart';
import '../res/colors/app_color.dart';

// Reusa enum AlertType para tipos de alerta
enum AlertType { info, success, warning, error }

// Clase para las acciones de diálogo
class DialogAction {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  DialogAction({
    required this.label,
    required this.onPressed,
    this.color,
  });
}

// Función para mostrar diálogo con múltiples acciones (modal)
Future<void> showCustomActionDialog(
  BuildContext context, {
  required AlertType type,
  required String title,
  required String message,
  required List<DialogAction> actions,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  // Colores e íconos según tipo
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
    barrierDismissible: false, // evitar cerrar tocando afuera
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      title: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      content: Text(message, style: textTheme.bodyMedium),
      actions: actions.map((action) {
        return TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(); // Cierra diálogo antes de ejecutar acción
            action.onPressed();
          },
          style: TextButton.styleFrom(
            foregroundColor: action.color ?? colorScheme.primary,
          ),
          child: Text(action.label),
        );
      }).toList(),
    ),
  );
}
