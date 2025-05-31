
import 'package:flutter/material.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isValidEmail = false;
  bool _isValidPass = false;
  bool _obscureText = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: _body,
    );
  }

  Widget get _body {
    return Center(
      child: Padding(padding: EdgeInsets.only(left: 16, right: 16), 
      child: Form(
        key: _formKey,
        child: Column(
        children: [
          LogoWidget(),
          Expanded(child: Column(
            children: [
              _emailWidget,
          SizedBox(height: 10,),
          _passwordWidget,
          SizedBox(height: 10,),
          _loginButton,
            ],
          )),
          _navigateToRegister
        ],
      )),)
    );
  }


  Widget get _emailWidget {
    return TextFormField(
        onChanged: (value){
          print("Value $value");
          if(value.contains("@")){
              setState(() {
                _isValidEmail = true;
              });
          }else{
            setState(() {
              _isValidEmail = false;
            });
          }
        },
        validator: (value){
            if(value!.isEmpty){
              return "Please input email";
            }
            return null;
        },
        decoration: InputDecoration(
          hintText: 'Email' ,
          prefixIcon: Icon(Icons.mail),
          suffixIcon: _isValidEmail ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.check_circle),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
    );
  }

  Widget get _passwordWidget {
    return TextFormField(
        onChanged: (value){
          print("Value $value");
          if(value.length < 6){
              setState(() {
                _isValidPass = true;
              });
          }else{
            setState(() {
              _isValidPass = false;
            });
          }
        },
        validator: (value){
            if(value!.isEmpty){
              return "Please input password";
            }

            if(_isValidPass){
              return "Please input invalid password";
            }
            return null;
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            child: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility, color: Colors.green,),
            onTap: (){
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
    );
  }

  Widget get _loginButton {

      return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red
        ),
        onPressed: (){
          if(_formKey.currentState!.validate()){
            // Process Call API
            AppRoute.key.currentState!.pushReplacementNamed(AppRoute.mainScreen);
          }else{
            // Display Error
          }
      }, child: Text("Login", style: TextStyle(color: Colors.white),)
    ),
      );
  }

  Widget get _navigateToRegister {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: (){
          AppRoute.key.currentState?.pushNamed(AppRoute.registerScreen);
        }, child: Text("Don't have an account, Register"))
      ],
    );
  }
}