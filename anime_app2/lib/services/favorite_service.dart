import 'package:flutter/material.dart';
import '../utils/shared_pref.dart';

class FavoriteService {
  static const keyFav = "favorite_ids";

  // ambil list favorit
  static Future<List<int>> getFavorites() async {
    return await SharedPref.loadIntList(keyFav);
  }

  // tambah
  static Future<void> add(int id) async {
    final list = await getFavorites();
    if (!list.contains(id)) {
      list.add(id);
      await SharedPref.saveIntList(keyFav, list);
    }
  }

  // hapus
  static Future<void> remove(int id) async {
    final list = await getFavorites();
    list.remove(id);
    await SharedPref.saveIntList(keyFav, list);
  }

  // cek apakah id favorit
  static Future<bool> isFav(int id) async {
    final list = await getFavorites();
    return list.contains(id);
  }
}
