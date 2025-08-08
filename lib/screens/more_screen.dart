import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/data/auth_share_pref.dart';
import 'package:mad_2_414/route/app_route.dart';
import 'package:mad_2_414/screens/account_screen.dart';
import 'package:mad_2_414/screens/language_screen.dart';
import 'package:mad_2_414/screens/login_screen.dart';
import 'package:mad_2_414/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String _fullName = "Guest";
  bool _isLogin = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _auth.currentUser!;
    setState(() {
      _fullName = user.email!.split("@")[0];
      _isLogin = user.email!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("more".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("language".tr),
                  subtitle: Text(
                    Get.locale?.languageCode == "km"
                        ? "khmerLanguage".tr
                        : "englishLanguage".tr,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(LanguageScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text("theme".tr),
                  subtitle: Text(
                    Get.isDarkMode ? "darkTheme".tr : "lightTheme".tr,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(ThemeScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text("profile".tr),
                  subtitle: Text("$_fullName"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _validateCurrentUser();
                  },
                ),
                Divider(),
              ],
            ),
          ),
          _isLogin ? _logoutButton : Container(),
        ],
      ),
    );
  }

  Widget get _logoutButton {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent),
          onPressed: () {
            _logout();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logout", style: TextStyle(color: Colors.white)),
              SizedBox(width: 4),
              Icon(Icons.logout, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateCurrentUser() async {
    try {
      if (_isLogin) {
        Get.to(AccountScreen());
      } else {
        Get.off(LoginScreen());
      }
    } catch (error) {
      print("Error : $error");
    }
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      Get.off(LoginScreen());
    } catch (error) {
      print("Error : $error");
    }
  }
}
