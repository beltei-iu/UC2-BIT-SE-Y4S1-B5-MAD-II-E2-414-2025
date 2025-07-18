import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/screens/main_screen.dart';
import 'package:mad_2_414/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: EdgeInsets.only(left: 16, right: 16), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            LogoWidget(),
        
           _createAccountButton,
            SizedBox(height: 10,),
           _loginAsGueestButton
           ],
        )),
      ),
    );
  }


  Widget get _createAccountButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red
      ),
      onPressed: () {
        AppRoute.key.currentState?.pushReplacementNamed(AppRoute.registerScreen);
      }, child: Text("Create Account", style: TextStyle(color: Colors.white),)
      ),
    );
  }

   Widget get _loginAsGueestButton {


    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
      onPressed: () {

        //AppRoute.key.currentState?.pushReplacementNamed(AppRoute.mainScreen);

        Get.off(() => MainScreen());

        }, child: Text("Login As Guest")
      
      ),
    );
  }
}
