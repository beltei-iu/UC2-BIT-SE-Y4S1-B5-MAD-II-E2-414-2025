import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {

  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  bool _isKhmer = true;

  @override
  void initState() {
    super.initState();
    _isKhmer = Get.locale?.languageCode == "km";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(
        children: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text("khmerLanguage".tr),
              trailing: Checkbox(value: _isKhmer, onChanged: (v){
                  Get.updateLocale(Locale("km","KH"));
                  setState(() {
                    _isKhmer = true;
                  });
              }),
            ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("englishLanguage".tr),
            trailing: Checkbox(value: !_isKhmer, onChanged: (v){
              Get.updateLocale(Locale("en","US"));
              setState(() {
                _isKhmer = false;
              });
            }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
