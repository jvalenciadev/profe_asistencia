import 'package:flutter/material.dart';
// Widget personalizado para icono con badge que usa theme del contexto
Widget iconWithBadge({
  required BuildContext context,
  required Widget icon,
  required int badgeCount,
  required VoidCallback onPressed,
  required String tooltip,
  Color? iconColor, // opcional, si no se pasa se usa color del tema
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return Stack(
    clipBehavior: Clip.none,
    children: [
      IconButton(
        icon: icon,
        color: iconColor ?? colorScheme.onSurface,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
      if (badgeCount > 0)
        Positioned(
          right: 6,
          top: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.surface, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 18,
              ),
            child: Text(
              badgeCount > 99 ? '99+' : badgeCount.toString(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                textAlign: TextAlign.center,
            ),
          ),
        ),
    ],
  );
}