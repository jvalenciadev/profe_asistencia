import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper.dart';
import 'notification.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 4,
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(250),
      shadowColor: Theme.of(context).shadowColor.withAlpha(25),
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: Icon(Icons.view_list_rounded, color: colorScheme.onSurface),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary.withAlpha(40),
            child: const Icon(
              Icons.local_hospital_rounded,
              color: Colors.teal,
              size: 25,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DentalCare App',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Tu salud dental en un solo lugar',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withAlpha(180),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        NotificationMenuWidget(
          notifications: [
            NotificationItem(
              id: 1,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: false,
            ),
            NotificationItem(
              id: 2,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: false,
            ),
            NotificationItem(
              id: 3,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: false,
            ),
            NotificationItem(
              id: 4,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: true,
            ),
            NotificationItem(
              id: 5,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: false,
            ),
            NotificationItem(
              id: 6,
              title: 'Nueva cita confirmada',
              description:
                  'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
              date: 'Hoy, 09:00 am',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
              visto: true,
            ),
          ],
          onNotificationTap: () {
            // Acción al tocar una notificación
          },
        ),
        iconWithBadge(
          context: context,
          icon: const Icon(Icons.smart_toy_outlined),
          badgeCount: 100,
          onPressed: () {
            // Acción para el chatbot
          },
          tooltip: 'ChatBot Dental',
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
          onSelected: (value) {
            // manejar menú
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'perfil',
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      const Text('Mi Perfil'),
                    ],
                  ),
                  onTap: () => Get.toNamed('/perfil_view'),
                ),
                PopupMenuItem(
                  value: 'ajustes',
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      const Text('Ajustes'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'soporte',
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      const Text('Soporte'),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
