import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatefulWidget {

  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {

  bool _isLight = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("theme".tr),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("lightTheme".tr),
            trailing: Checkbox(value: _isLight, onChanged: (v){
              Get.changeTheme(ThemeData.light());
              setState(() {
                _isLight = true;
              });
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("darkTheme".tr),
            trailing: Checkbox(value: !_isLight, onChanged: (v){
              Get.changeTheme(ThemeData.dark());
              setState(() {
                _isLight = false;
              });
            }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
