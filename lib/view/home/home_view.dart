import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:profe_asistencia/view/home/home_screen.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final homeController = Get.put(HomeController(), permanent: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _loadHomeData();
    });
  }

  // Future<void> _loadHomeData() async {
  //   try {
  //     homeController.onInit();
  //   } catch (e) {
  //     showCustomSnackbar(
  //       title: 'Error',
  //       message: 'Failed to load home data ${e.toString()}',
  //       isError: true,
  //     );
  //   }
  // }

  Future<bool> _onWillPop() async {
    final exit = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text('¿Salir?', style: TextStyle(fontFamily: AppFonts.mina)),
            content: Text(
              '¿Deseas cerrar la aplicación?',
              style: TextStyle(fontFamily: AppFonts.mina),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
                onPressed: () => Navigator.of(c).pop(true),
                child: Text(
                  'Salir',
                  style: TextStyle(
                    fontFamily: AppFonts.mina,
                    color: AppColor.whiteColor,
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

  int _currentIndex = 2;
   void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  final List<String> _titles = [
    "Eventos",
    "Ofertas académicas",
    "Home",
    "Sedes",
    "Información",
  ];
  
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(), // pasa la función
      HomeScreen(), // pasa la función
      HomeScreen(), // pasa la función
      HomeScreen(), // pasa la función
    ];
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 660;
    return PopScope(
      canPop: false, // Para evitar que se cierre automáticamente
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        appBar:
            isSmallScreen
                ? null // ❌ Oculta AppBar completamente si la pantalla es muy pequeña
                : AppBar(
                  automaticallyImplyLeading:
                      false, // No muestra el ícono de "atrás"
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primaryColor,
                          AppColor.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Título de la sección
                      Text(
                        _titles[_currentIndex],
                        style: TextStyle(
                          fontFamily: 'Mina',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Logo de la empresa
                      Image.asset(
                        ImageAssets.logoProfe,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
        bottomNavigationBar: SafeArea(child: _buildBottomNavBar()),
        body: screens[_currentIndex],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 3),
      child: GNav(
        rippleColor: AppColor.secondaryColor,
        hoverColor: AppColor.primaryColor,
        backgroundColor: AppColor.whiteColor,
        color: AppColor.primaryColor,
        activeColor: AppColor.whiteColor,
        tabActiveBorder: Border.all(color: AppColor.whiteColor, width: 1),
        tabBorder: Border.all(color: AppColor.whiteColor, width: 1),
        tabShadow: const [BoxShadow(color: AppColor.whiteColor, blurRadius: 8)],
        curve: Curves.bounceIn,
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: AppColor.secondaryColor,
        gap: 8,
        tabBorderRadius: 15,
        haptic: true,
        onTabChange: (index) => setState(() => _currentIndex = index),
        selectedIndex: _currentIndex,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.calendarDays,
            iconSize: 20,
            text: 'Eventos',
          ),
          GButton(
            icon: FontAwesomeIcons.graduationCap,
            iconSize: 20,
            text: 'Ofertas',
          ),
          GButton(
            icon: FontAwesomeIcons.houseChimney,
            iconSize: 20,
            text: 'Home',
          ),
          GButton(icon: FontAwesomeIcons.building, iconSize: 20, text: 'Sedes'),
        ],
      ),
    );
  }
}
