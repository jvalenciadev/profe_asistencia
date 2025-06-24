import 'package:flutter/material.dart';
import '../../view_models/controller/theme/theme_controller.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Theme.of(context).appBarTheme.backgroundColor),
          ),
          onPressed: () => themeController.toggleTheme(),
          child: Obx(
            () => Text(
              
              themeController.isDarkMode.value
                  ? "Cambiar a Claro"
                  : "Cambiar a Oscuro",
                  style:TextStyle(color:  Theme.of(context).appBarTheme.foregroundColor),
            ),
          ),
        ),
    );
  }
}
