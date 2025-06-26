import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper.dart';
import 'notification.dart';

class CustomAppBarInBody extends StatelessWidget {
  const CustomAppBarInBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: kToolbarHeight + 10,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(10),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.view_list_rounded, color: colorScheme.onSurface),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            backgroundColor: colorScheme.primary.withAlpha(40),
            child: const Icon(Icons.local_hospital_rounded, color: Colors.teal),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DentalCare App',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Tu salud dental en un solo lugar',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          NotificationMenuWidget(
            notifications: [
              NotificationItem(
                id: 1,
                title: 'Nueva cita confirmada',
                description: 'Tu cita con el Dr. Pérez fue confirmada.',
                date: 'Hoy, 09:00 am',
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
                visto: false,
              ),
            ],
            onNotificationTap: () {},
          ),
          iconWithBadge(
            context: context,
            icon: const Icon(Icons.smart_toy_outlined),
            badgeCount: 100,
            onPressed: () {},
            tooltip: 'ChatBot Dental',
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'perfil',
                onTap: () => Get.toNamed('/perfil_view'),
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 18, color: colorScheme.onSurface),
                    const SizedBox(width: 8),
                    const Text('Mi Perfil'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'ajustes',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 18, color: colorScheme.onSurface),
                    const SizedBox(width: 8),
                    const Text('Ajustes'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'soporte',
                child: Row(
                  children: [
                    Icon(Icons.help_outline_rounded, size: 18, color: colorScheme.onSurface),
                    const SizedBox(width: 8),
                    const Text('Soporte'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
