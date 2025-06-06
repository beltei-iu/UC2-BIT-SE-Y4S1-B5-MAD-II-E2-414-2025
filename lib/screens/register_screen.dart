import 'package:flutter/material.dart';
import 'package:mad_2_414/data/auth_share_pref.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/widgets/logo_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isValidEmail = false;
  bool _isValidPass = false;
  bool _obscureText = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    _fullNameWidget,
                    SizedBox(height: 10),
                    _emailWidget,
                    SizedBox(height: 10),
                    _passwordWidget,
                    SizedBox(height: 10),
                    _registerButton,
                  ],
                ),
              ),
              _navigateToLogin,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _fullNameWidget {
    return TextFormField(
      controller: _fullNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input full name";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Full Name',
        prefixIcon: Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          child:
              _obscureText
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

  Widget get _registerButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process Call API

            String fullName = _fullNameController.text;
            String email = _emailController.text;
            String password = _passwordController.text;

            print("Full Name: $fullName");
            print("Email: $email");
            print("Password: $password");

            AuthSharePref.register(fullName, email, password);

            AppRoute.key.currentState!.pushReplacementNamed(
              AppRoute.mainScreen,
            );
          } else {
            // Display Error
          }
        },
        child: Text("Register", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget get _navigateToLogin {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account? "),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              AppRoute.key.currentState!.pushReplacementNamed(
                AppRoute.loginScreen,
              );
            },
            child: Text(
              " Login",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
