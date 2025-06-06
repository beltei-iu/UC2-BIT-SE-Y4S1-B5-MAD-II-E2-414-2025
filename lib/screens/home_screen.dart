import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName = "Guest";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("fullName");
    String? email = prefs.getString("email");

    // await Future.delayed(Duration(seconds: 2));
    setState(() {
      this.fullName = username ?? email ?? "Guest";
    });
    print("User data loaded");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: Center(child: Text("Home")));
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Text("Hi, $fullName"),
      elevation: 2,
      actions: [
        Icon(Icons.notifications),
        Icon(Icons.search),
        Icon(Icons.more_vert),
      ],
    );
  }
}
