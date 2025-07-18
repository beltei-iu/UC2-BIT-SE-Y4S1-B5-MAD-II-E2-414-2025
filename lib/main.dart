import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/data/db_sqflite_manager.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/screens/splash_screen.dart';
import 'package:mad_2_414/services/category_service.dart';
import 'package:mad_2_414/translate/message.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Make Widget Initailize
  WidgetsFlutterBinding.ensureInitialized();
  // init DB
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  DbSqfliteManager.instance.database;

  // Demo
  final categoryService = CategoryService();
  // Insert Data
  // final category = Category(name: 'Apple', nameKh: 'Apple');
  // categoryService.insertCategory(category);

  // Query
  // categoryService
  //     .getCategory()
  //     .then((v) {
  //       print("Cateogry : $v");
  //     })
  //     .catchError((e) {
  //       print("Error : $e");
  //     });

  runApp(App());


  // // Provider
  // final provider = MultiProvider(
  //   providers: [
  //    ChangeNotifierProvider(create: (_) => CartProvider()),
  //     // ...
  //   ],
  //   child: App(),
  // );
  // runApp(provider);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    // GetX
    return GetMaterialApp(
      title: 'Book Shop',

      // Option 1
      //home: SplashScreen(),

      // Option 2
      // routes: {

      // },

      // Option 3
      //initialRoute: AppRoute.splashScreen,
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
