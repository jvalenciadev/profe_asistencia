import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/services.dart';

import '../../res/assets/image_assets.dart';
import '../../res/fonts/app_fonts.dart';
import '../home/home_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 2;

  final List<String> _titles = [
    'eventos'.tr,
    'ofertas_academicas'.tr,
    'home'.tr,
    'sedes'.tr,
    'informacion'.tr,
  ];

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
    final isSmallScreen = MediaQuery.of(context).size.height < 660;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        appBar:
            isSmallScreen
                ? null
                : AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colorScheme.secondary, colorScheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _titles[_currentIndex],
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.surface,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Image.asset(
                        ImageAssets.logoProfe,
                        width: 120,
                        fit: BoxFit.contain,
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

  Widget _buildBottomNavBar(ThemeData theme, ColorScheme colorScheme) {
    final iconColor = theme.iconTheme.color;
    final iconSize = theme.iconTheme.size ?? 20;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 3),
      child: GNav(
        rippleColor: colorScheme.secondary.withOpacity(0.2),
        hoverColor: colorScheme.primary.withOpacity(0.1),
        backgroundColor: colorScheme.surface,
        color: iconColor,
        activeColor: colorScheme.onPrimary,
        tabBackgroundColor: colorScheme.secondary,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        gap: 8,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        tabBorderRadius: 15,
        haptic: true,
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
