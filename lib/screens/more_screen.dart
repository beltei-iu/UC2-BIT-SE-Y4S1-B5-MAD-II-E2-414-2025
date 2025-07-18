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
      appBar: AppBar(
        title: Text("More"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0.5,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("English"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Theme"),
            subtitle: Text("Dark"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
        ],
      ),
    );
  }
}
