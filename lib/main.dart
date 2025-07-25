import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/data/db_sqflite_manager.dart';
import 'package:mad_2_414/firebase_options.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/screens/splash_screen.dart';
import 'package:mad_2_414/translate/message.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Make Widget Initialize
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // init DB
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  DbSqfliteManager.instance.database;
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Book Shop',
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
      home: SplashScreen(),

      // Translate
      translations: Message(),
      locale: Get.deviceLocale,

      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
