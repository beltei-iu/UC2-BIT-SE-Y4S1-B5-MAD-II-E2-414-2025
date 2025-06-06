import 'package:shared_preferences/shared_preferences.dart';

class AuthSharePref {
  static Future<void> register(
    String fullName,
    String email,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove("email");
    // await prefs.remove("password");
    // await prefs.remove("fullName");
    await prefs.clear(); // Clear all preferences
  }
}
