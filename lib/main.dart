import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final _db = FirebaseDatabase.instance;
  // final _dbRef = await _db.ref("products");
  // List<Map<String, dynamic>> dataReq = [
  //   {
  //     "name_kh": "iPhone 15 Pro",
  //     "name_en": "iPhone 15 Pro",
  //     "brand": "Apple",
  //     "price": 1450,
  //     "stock": 5,
  //     "image": "https://example.com/iphone15pro.jpg",
  //   },
  //   {
  //     "name_kh": "Samsung Galaxy S23",
  //     "name_en": "Samsung Galaxy S23",
  //     "brand": "Samsung",
  //     "price": 1200,
  //     "stock": 8,
  //     "image": "https://example.com/galaxy_s23.jpg",
  //   },
  // ];
  // final updates = <String, dynamic>{};
  // for (var item in dataReq) {
  //   final newKey = _dbRef.child("products").push().key; // Generate unique ID
  //   updates["products/$newKey"] = item; // Add to batch
  // }
  // await _dbRef.update(updates); // Push all at once
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
