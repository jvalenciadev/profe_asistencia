import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'res/colors/app_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'res/getx_loclization/languages.dart';
import 'res/routes/routes.dart';
import 'view_models/controller/app_view_models.dart';


void main() async{
  await dotenv.load(fileName: "assets/.env");
  Get.put(AppInfoController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.grey3Color,
        colorScheme: ColorScheme.light(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'App PROFE',
      translations: Languages(),
      locale: const Locale('es', 'BO'),
      fallbackLocale: const Locale('es', 'BO'),
      getPages: AppRoutes.appRoutes(),
      //  ↓↓↓ AGREGA ESTO ↓↓↓
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Español
        Locale('es', 'BO'), // Español (Bolivia), si prefieres
        Locale('en', 'US'), // Inglés como fallback
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
