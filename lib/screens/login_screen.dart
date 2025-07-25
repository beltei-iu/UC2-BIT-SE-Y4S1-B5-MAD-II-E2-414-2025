import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/data/auth_share_pref.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/screens/main_screen.dart';
import 'package:mad_2_414/widgets/logo_widget.dart';
import 'package:mad_2_414/widgets/social_login_widget.dart';

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

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }

  Widget get _body {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LogoWidget(),
              Expanded(
                child: Column(
                  children: [
                    _emailWidget,
                    SizedBox(height: 10),
                    _passwordWidget,
                    SizedBox(height: 10),
                    _loginButton,
                    SizedBox(height: 10),
                    SocialLoginWidget(),
                  ],
                ),
              ),
              _navigateToRegister,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _emailWidget {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        print("Value $value");
        if (value.contains("@")) {
          setState(() {
            _isValidEmail = true;
          });
        } else {
          setState(() {
            _isValidEmail = false;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input email";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail),
        suffixIcon:
            _isValidEmail
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.check_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _passwordWidget {
    return TextFormField(
      controller: _passwordController,
      onChanged: (value) {
        print("Value $value");
        if (value.length < 6) {
          setState(() {
            _isValidPass = true;
          });
        } else {
          setState(() {
            _isValidPass = false;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input password";
        }
        if (_isValidPass) {
          return "Please input invalid password";
        }
        return null;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: GestureDetector(
          child:  _obscureText
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility, color: Colors.green),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _loginButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final email = _emailController.text;
            final password = _passwordController.text;
            AuthSharePref.login(email, password);
            _onLogin(email, password);
          } else {
            // Display Error
          }
        },
        child: Text("Login", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget get _navigateToRegister {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              AppRoute.key.currentState!.pushNamed(AppRoute.registerScreen);
            },
            child: Text(
              "Register",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogin(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
            Get.off(MainScreen());
          }).catchError((error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$error")));
        print("Error");
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
      print("Error : $e");
    }
  }
}
