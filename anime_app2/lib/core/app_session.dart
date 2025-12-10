import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  // Simpan user baru (register)
  static Future<void> saveUser(
      String username, String email, String password) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("username", username);
    await pref.setString("email", email);
    await pref.setString("password", password);
  }

  // Login check
  static Future<bool> login(String email, String password) async {
    final pref = await SharedPreferences.getInstance();
    final savedEmail = pref.getString("email");
    final savedPass = pref.getString("password");

    if (email == savedEmail && password == savedPass) {
      await pref.setBool("isLoggedIn", true);
      return true;
    }
    return false;
  }

  // Logout user
  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
  }

  // Check apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool("isLoggedIn") ?? false;
  }

  // Ambil data user
  static Future<Map<String, String>> getUser() async {
    final pref = await SharedPreferences.getInstance();
    return {
      "username": pref.getString("username") ?? "",
      "email": pref.getString("email") ?? "",
    };
  }
}
