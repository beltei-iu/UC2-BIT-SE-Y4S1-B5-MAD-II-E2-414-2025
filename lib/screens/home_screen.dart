
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar,
      body: Center(
        child: Text("Home"),
      ),
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Icon(Icons.menu),
      elevation: 2,
      actions: [
        Icon(Icons.notifications),
        Icon(Icons.search),
        Icon(Icons.more_vert)
      ],
    );
  }
}