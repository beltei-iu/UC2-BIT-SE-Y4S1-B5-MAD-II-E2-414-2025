import 'package:flutter/material.dart';
import 'package:mad_2_414/data/auth_share_pref.dart';
import 'package:mad_2_414/route/app_route.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthSharePref.logout();
            AppRoute.key.currentState?.pushReplacementNamed(
              AppRoute.loginScreen,
            );
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
