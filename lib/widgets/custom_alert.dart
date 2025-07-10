// 📦 lib/widgets/custom_alert.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../res/colors/app_color.dart';

enum AlertType { info, success, warning, error }

class CustomAlertOverlay {
  static void show(
    BuildContext context, {
    required AlertType type,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: _AnimatedAlertEntry(
              duration: duration,
              onDismissed: () => overlayEntry.remove(),
              child: CustomAlert(
                type: type,
                title: title,
                message: message,
                onClose: () => overlayEntry.remove(),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);
  }
}

class _AnimatedAlertEntry extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback onDismissed;

  const _AnimatedAlertEntry({
    required this.child,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_AnimatedAlertEntry> createState() => _AnimatedAlertEntryState();
}

class _AnimatedAlertEntryState extends State<_AnimatedAlertEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _controller.reverse().then((_) => widget.onDismissed());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

class CustomAlert extends StatelessWidget {
  final AlertType type;
  final String title;
  final String message;
  final VoidCallback? onClose;

  const CustomAlert({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color iconColor;
    IconData icon;

    Color bgColor = switch (type) {
      AlertType.success => AppColor.sentColor,
      AlertType.warning => AppColor.warningColor,
      AlertType.error => AppColor.errorColor,
      AlertType.info => AppColor.infoColor,
    }.withValues(alpha: 0.08);

    iconColor = switch (type) {
      AlertType.success => AppColor.sentColor,
      AlertType.warning => AppColor.warningColor,
      AlertType.error => AppColor.errorColor,
      AlertType.info => AppColor.infoColor,
    };

    icon = switch (type) {
      AlertType.success => Icons.check_circle_outline,
      AlertType.warning => Icons.warning_amber_rounded,
      AlertType.error => Icons.error_outline,
      AlertType.info => Icons.info_outline,
    };

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor.withValues(alpha: 0.70),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: iconColor.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconColor.withValues(alpha: 0.15),
              child: Icon(icon, color: colorScheme.surface, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.surface,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            if (onClose != null)
              IconButton(
                splashRadius: 20,
                icon: Icon(
                  Icons.close,
                  size: 20,
                  color: colorScheme.surface.withValues(alpha: 0.7),
                ),
                onPressed: onClose,
                tooltip: 'Cerrar',
              ),
          ],
        ),
      ),
    );
  }
}
