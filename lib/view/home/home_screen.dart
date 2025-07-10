import 'package:flutter/material.dart';
import '../../utils/auth_util.dart';
import '../../widgets/custom_alert.dart' as alert;
import '../../widgets/custom_alert_action_dialog.dart' as alertdialog;
import '../../widgets/custom_alert_confirm.dart' as alertconfirm;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox.expand(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              alert.CustomAlertOverlay.show(
                context,
                type: alert.AlertType.success,
                title: 'Éxito',
                message: 'Tu cita fue registrada correctamente.',
              );
            },
            child: const Text('Alerta de Éxito'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              alert.CustomAlertOverlay.show(
                context,
                type: alert.AlertType.warning,
                title: 'Advertencia',
                message: 'Algunos campos están incompletos.',
              );
            },
            child: const Text('Alerta de Advertencia'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              alert.CustomAlertOverlay.show(
                context,
                type: alert.AlertType.error,
                title: 'Error',
                message: 'Ocurrió un problema inesperado.',
              );
            },
            child: const Text('Alerta de Error'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              alert.CustomAlertOverlay.show(
                context,
                type: alert.AlertType.info,
                title: 'Información',
                message: 'Puedes actualizar tu perfil desde el menú.',
              );
            },
            child: const Text('Alerta de Información'),
          ),
          const Divider(height: 32),
          ElevatedButton(
            onPressed: () {
              alertconfirm.showCustomConfirmationDialog(
                context,
                type: alert.AlertType.error,
                title: '¿Estás seguro?',
                message: 'Esta acción no se puede deshacer.',
                onConfirm: () => print('Confirmado'),
                onCancel: () => print('Cancelado'),
              );
            },
            child: const Text('Alerta con Confirmación'),
          ),
          ElevatedButton(
            onPressed: () {
              alertdialog.showCustomActionDialog(
                context,
                type: alertdialog.AlertType.success,
                title: 'Opciones Disponibles',
                message: '¿Qué acción deseas realizar?',
                actions: [
                  alertdialog.DialogAction(
                    label: 'Ver Detalles',
                    onPressed: () => print('Detalles'),
                  ),
                  alertdialog.DialogAction(
                    label: 'Ignorar',
                    onPressed: () => print('Ignorado'),
                    color: Colors.grey,
                  ),
                ],
              );
            },
            child: const Text('Alerta con Múltiples Acciones (Diálogo)'),
          ),
          ElevatedButton(
            child: const Text("Autenticarse con biometría"),
            onPressed: () async {
              final success = await AuthUtil.authenticate(
                reason: 'Autenticación necesaria para continuar',
              );

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("¡Autenticación exitosa!")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fallo en la autenticación")),
                );
              }
            },
          ),
          const SizedBox(height: 24),
          Text('labelSmall - Etiqueta pequeña', style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
