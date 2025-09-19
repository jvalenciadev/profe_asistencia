import 'package:get/get.dart';
import 'package:profe_asistencia/view/configuracion/configuracion_view.dart';
import 'package:profe_asistencia/view/splash_screen.dart';
import 'package:profe_asistencia/widgets/update_app_view.dart';
import '../../res/routes/routes_name.dart';
import '../../view/barcode/barcode_view.dart';
import '../../view/home/home_view.dart';
import '../../view/perfil/perfil_view.dart';
import '../../view/presentacion_screan.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.presentacionView,
      page: () => PresentacionScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.homeView,
      page: () => HomeView(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.noTransition,
    ),
    
    GetPage(
      name: RouteName.updateAppView,
      page: () => UpdateAppView(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.perfilView,
      page: () => PerfilView(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.configuracionView,
      page: () => ConfiguracionSistemaWidget(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.barcodeView,
      page: () => BarcodeScannerPage(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
  ];
}
