import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/services.dart';
import '../../res/fonts/app_fonts.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar(),
        body: _screens[_currentIndex], // Contenido dinámico debajo del appbar
        // bottomNavigationBar: SafeArea(
        //   child: _buildBottomNavBar(theme, colorScheme),
        // ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        gap: 8,
        haptic: true,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        selectedIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
        tabs: [
          GButton(
            icon: FontAwesomeIcons.calendarCheck,
            iconSize: iconSize,
            text: 'Citas',
          ),
          GButton(
            icon: FontAwesomeIcons.fileMedical,
            iconSize: iconSize,
            text: 'Historial',
          ),
          GButton(
            icon: FontAwesomeIcons.creditCard,
            iconSize: iconSize,
            text: 'Pagos',
          ),
          GButton(
            icon: FontAwesomeIcons.tooth,
            iconSize: iconSize,
            text: 'Servicios',
          ),
          GButton(
            icon: FontAwesomeIcons.commentDots,
            iconSize: iconSize,
            text: 'Consultas',
          ),
          GButton(
            icon: FontAwesomeIcons.userGear,
            iconSize: iconSize,
            text: 'Perfil',
          ),
        ],
      ),
    );
  }
}
