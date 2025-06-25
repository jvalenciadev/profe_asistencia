import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/services.dart';
import '../../res/fonts/app_fonts.dart';
import '../../widgets/helper.dart';
import '../../widgets/notification.dart';
import '../home/home_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  Future<bool> _onWillPop() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final exit = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text('salir_titulo'.tr, style: textTheme.titleLarge),
            content: Text('salir_mensaje'.tr, style: textTheme.bodyMedium),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: Text(
                  'cancelar'.tr,
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                ),
                onPressed: () => Navigator.of(c).pop(true),
                child: Text(
                  'salir'.tr,
                  style: TextStyle(
                    fontFamily: AppFonts.mina,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
    );
    if (exit == true) {
      SystemNavigator.pop();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    // final isSmallScreen = MediaQuery.of(context).size.height < 660;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: 0.98),
          shadowColor: Theme.of(context).shadowColor.withValues(alpha: 0.1),
          // NO LEADING para que salga el botón hamburguesa automáticamente
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(
                    Icons.view_list_rounded,
                    color: colorScheme.onSurface,
                  ), // Aquí el icono que quieras, por ejemplo un diente
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Esto abre el Drawer
                  },
                ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.15),
                child: const Icon(
                  Icons.local_hospital_rounded,
                  color: Colors.teal,
                  size: 25,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                // <-- Aquí para que el texto ocupe el espacio restante y no sobrepase
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'DentalCare App',
                      overflow:
                          TextOverflow
                              .ellipsis, // <-- para truncar con puntos suspensivos
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
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
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
              badgeCount: 152,
              notifications: [
                NotificationItem(
                  title: 'Nueva cita confirmada',
                  description:
                      'Tu cita con el Dr. Pérez fue confirmada para mañana 10:00 am.',
                  date: 'Hoy, 09:00 am',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/2913/2913461.png',
                ),
                NotificationItem(
                  title: 'Recordatorio: limpieza dental',
                  description:
                      'No olvides tu limpieza programada para el 28 de junio.',
                  date: 'Ayer, 04:30 pm',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/2933/2933882.png',
                ),
                NotificationItem(
                  title: 'Recordatorio: limpieza dental',
                  description:
                      'No olvides tu limpieza programada para el 28 de junio.',
                  date: 'Ayer, 04:30 pm',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/2933/2933882.png',
                ),
                NotificationItem(
                  title: 'Recordatorio: limpieza dental',
                  description:
                      'No olvides tu limpieza programada para el 28 de junio.',
                  date: 'Ayer, 04:30 pm',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/2933/2933882.png',
                ),
                NotificationItem(
                  title: 'Recordatorio: limpieza dental',
                  description:
                      'No olvides tu limpieza programada para el 28 de junio.',
                  date: 'Ayer, 04:30 pm',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/2933/2933882.png',
                ),
                // Agrega más notificaciones si quieres
              ],
              onNotificationTap: () {
                // Aquí pones lo que quieres que pase al tocar una notificación
              },
            ),
            iconWithBadge(
              context: context,
              icon: const Icon(Icons.smart_toy_outlined),
              badgeCount: 100,
              onPressed: () {
                // Acción para chatbot
              },
              tooltip: 'ChatBot Dental',
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
              onSelected: (value) {
                // Manejar acción de menú
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
                          SizedBox(width: 8),
                          Text('Mi Perfil'),
                        ],
                      ),
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
                          SizedBox(width: 8),
                          Text('Ajustes'),
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
                          SizedBox(width: 8),
                          Text('Soporte'),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),

        drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              // Encabezado estilizado con sombra y padding
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
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
                      backgroundColor: colorScheme.primary.withValues(
                        alpha: 0.15,
                      ),
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
                              color: colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
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
                        onPressed: () => Get.toNamed('/perfil'),
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
                      },
                      {
                        'icon': FontAwesomeIcons.calendarDays,
                        'label': 'Eventos',
                      },
                      {
                        'icon': FontAwesomeIcons.graduationCap,
                        'label': 'Ofertas',
                      },
                      {'icon': FontAwesomeIcons.building, 'label': 'Sedes'},
                      {'icon': FontAwesomeIcons.gear, 'label': 'Configuración'},
                    ])
                      _drawerButton(
                        icon: item['icon'] as IconData,
                        label: item['label'] as String,
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
                      icon: FontAwesomeIcons.moon,
                      label: 'Modo oscuro',
                    ),
                    _drawerButton(
                      icon: FontAwesomeIcons.language,
                      label: 'Idioma',
                    ),
                    _drawerButton(icon: FontAwesomeIcons.font, label: 'Fuente'),
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
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: SafeArea(
          child: _buildBottomNavBar(theme, colorScheme),
        ),
      ),
    );
  }

  // Función privada para construir botones con Material + InkWell para mejor UX
  Widget _drawerButton({required IconData icon, required String label}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: colorScheme.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: colorScheme.onSurface.withValues(alpha: 0.2),
          highlightColor: colorScheme.onSurface.withValues(alpha: 0.1),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 32, // ancho fijo para el icono
                  alignment: Alignment.center,
                  child: FaIcon(
                    icon,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: textTheme.bodyLarge?.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(ThemeData theme, ColorScheme colorScheme) {
    final iconSize = theme.iconTheme.size ?? 20;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 3),
      child: GNav(
        rippleColor: colorScheme.secondary.withValues(alpha: 0.15),
        hoverColor: colorScheme.primary.withValues(alpha: 0.1),
        backgroundColor: Theme.of(context).dividerColor,
        color: colorScheme.onSurface.withValues(alpha: 0.9), // Icono inactivo
        activeColor: colorScheme.primary, // Icono activo
        tabBackgroundColor: colorScheme.primary.withValues(
          alpha: 0.15,
        ), // Fondo del tab activo
        tabBorderRadius: 20,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gap: 8,
        haptic: true,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        selectedIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
        tabs: [
          GButton(
            icon: FontAwesomeIcons.calendarDays,
            iconSize: iconSize,
            text: 'eventos'.tr,
          ),
          GButton(
            icon: FontAwesomeIcons.graduationCap,
            iconSize: iconSize,
            text: 'ofertas'.tr,
          ),
          GButton(
            icon: FontAwesomeIcons.houseChimney,
            iconSize: iconSize,
            text: 'home'.tr,
          ),
          GButton(
            icon: FontAwesomeIcons.building,
            iconSize: iconSize,
            text: 'sedes'.tr,
          ),
        ],
      ),
    );
  }
}
