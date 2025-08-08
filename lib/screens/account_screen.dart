import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mad_2_414/main.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _imageUrl = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      final userData = await FacebookAuth.instance.getUserData(
        fields: "email,name,picture.width(200)",
      );
      print('Email: ${userData['email']}');
      print('Picture:${userData['picture']['data']['url']}');
      setState(() {
        _imageUrl = userData['picture']['data']['url'];
      });
    }
  }

  Future<bool> _isLoggedIn() async {
    final token = await FacebookAuth.instance.accessToken;
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account"), elevation: 0.5, centerTitle: true),
      body: Center(child: Image.network("$_imageUrl")),
    );
  }
}
