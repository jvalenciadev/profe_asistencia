import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          // Encabezado estilizado con sombra y padding
          Container(
            width: double.infinity,

            padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.06),
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.04),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ícono de usuario
                CircleAvatar(
                  radius: 25,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                  child: Icon(
                    FontAwesomeIcons.user,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),

                // Información de usuario
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juan Pablo Valencia Catari",
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "juanpablo.valencia@correo.com",
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),

                      // Rol con badge e ícono
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_user_rounded,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Cliente",
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Botón de configuración
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      size: 22,
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    tooltip: 'Configurar perfil',
                    onPressed: () => Get.toNamed('/perfil_view'),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                for (final item in [
                  {
                    'icon': FontAwesomeIcons.houseChimney,
                    'label': 'Inicio',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.calendarCheck,
                    'label': 'Citas',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.fileMedical,
                    'label': 'Historial',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.tooth,
                    'label': 'Servicios',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.creditCard,
                    'label': 'Pagos',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.commentDots,
                    'label': 'Consultas',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.userGear,
                    'label': 'Perfil',
                    'onPressed': () {},
                  },
                  {
                    'icon': FontAwesomeIcons.gear,
                    'label': 'Configuración',
                    'onPressed': () => Get.toNamed('/configuracion_view'),
                  },
                ])
                  _drawerButton(
                    context: context,
                    icon: item['icon'] as IconData,
                    label: item['label'] as String,
                    onPressed: item['onPressed'] as VoidCallback,
                  ),
              ],
            ),
          ),

          Divider(
            height: 20,
            thickness: 1,
            color: colorScheme.onSurface.withValues(alpha: 0.2),
          ),

          // Opciones visuales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _drawerButton(
                  context: context,
                  icon: FontAwesomeIcons.moon,
                  label: 'Modo oscuro',
                  onPressed: () {},
                ),
                _drawerButton(
                  context: context,
                  icon: FontAwesomeIcons.language,
                  label: 'Idioma',
                  onPressed: () {},
                ),
                _drawerButton(
                  context: context,
                  icon: FontAwesomeIcons.font,
                  label: 'Fuente',
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const Spacer(),

          // Botón cerrar sesión elegante
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
            child: Align(
              alignment: Alignment.topRight,
              child: Material(
                color: colorScheme.error.withValues(alpha: 0.92),
                shape: const CircleBorder(),
                elevation: 3,
                shadowColor: colorScheme.error.withValues(alpha: 0.35),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    // Acción de cerrar sesión
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función privada para construir botones con Material + InkWell para mejor UX
  Widget _drawerButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        elevation: 2,
        shadowColor: colorScheme.shadow.withValues(alpha: 0.08),
        color: colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          splashColor: colorScheme.primary.withValues(alpha: 0.08),
          highlightColor: colorScheme.primary.withValues(alpha: 0.04),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(icon, size: 18, color: colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
