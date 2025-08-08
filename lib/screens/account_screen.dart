import 'package:flutter/material.dart';
import 'package:mad_2_414/main.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account"), elevation: 0.5, centerTitle: true),
      body: Center(child: Text("Account")),
    );
  }
}
