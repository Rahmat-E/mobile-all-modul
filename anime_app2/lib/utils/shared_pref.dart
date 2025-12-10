import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Save any map
  static Future<void> saveMap(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  // Load any map
  static Future<Map<String, dynamic>?> loadMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw);
  }

  // Save list<int> (favorites)
  static Future<void> saveIntList(String key, List<int> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        key, list.map((e) => e.toString()).toList());
  }

  // Load list<int>
  static Future<List<int>> loadIntList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key);
    if (list == null) return [];
    return list.map(int.parse).toList();
  }

  // Save string
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Load string
  static Future<String?> loadString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Remove key
  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
