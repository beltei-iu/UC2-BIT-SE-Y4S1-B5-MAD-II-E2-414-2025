
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mad_2_414/screens/login_screen.dart';
import 'package:mad_2_414/screens/main_screen.dart';
import 'package:mad_2_414/screens/register_screen.dart';
import 'package:mad_2_414/screens/splash_screen.dart';

class AppRoute {

  static const splashScreen = "";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
  static const mainScreen = "/mainScreen";

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){

    switch(routeSettings.name){
        case splashScreen:
          return _buildRoute(routeSettings, SplashScreen());
        case loginScreen:
          return _buildRoute(routeSettings, LoginScreen());
        case registerScreen:
          return _buildRoute(routeSettings, RegisterScreen());
        case mainScreen:
          return _buildRoute(routeSettings, MainScreen());
        default:
          throw RouteException("Route not found.");
    }
  }

  static Route<dynamic> _buildRoute(RouteSettings routeSettings, Widget newScreen){
    return MaterialPageRoute(settings:  routeSettings, builder: (context) => newScreen);
  }
}

class RouteException implements Exception {

  String message;

  RouteException(this.message);

}