import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/anime.dart';
import '../models/anime_detail.dart';

class AnimeApi {
  // GET Top Anime Ranking
  static Future<List<Anime>> getTopAnime() async {
    final url =
        "${Constants.baseUrl}/anime/ranking?ranking_type=all&limit=20&fields=id,title,main_picture,mean,start_date";

    final res = await http.get(
      Uri.parse(url),
      headers: {"X-MAL-CLIENT-ID": Constants.clientId},
    );

    if (res.statusCode != 200) throw Exception("Failed to load ranking");

    final data = jsonDecode(res.body);

    return (data["data"] as List).map((item) {
      final d = item["node"];
      return Anime(
        id: d["id"],
        title: d["title"],
        image: d["main_picture"]?["large"],
        mean: d["mean"]?.toDouble(),
        year: d["start_date"] != null
            ? DateTime.parse(d["start_date"]).year
            : null,
      );
    }).toList();
  }

  // SEARCH
  static Future<List<Anime>> searchAnime(String q) async {
    final url =
        "${Constants.baseUrl}/anime?q=$q&limit=20&fields=id,title,main_picture,mean,start_date";

    final res = await http.get(
      Uri.parse(url),
      headers: {"X-MAL-CLIENT-ID": Constants.clientId},
    );

    if (res.statusCode != 200) throw Exception("Search error");

    final data = jsonDecode(res.body);

    return (data["data"] as List).map((item) {
      final d = item["node"];
      return Anime(
        id: d["id"],
        title: d["title"],
        image: d["main_picture"]?["large"],
        mean: d["mean"]?.toDouble(),
        year: d["start_date"] != null
            ? DateTime.parse(d["start_date"]).year
            : null,
      );
    }).toList();
  }

  // SEASONAL
  static Future<List<Anime>> getSeasonAnime(int year, String season) async {
    final url =
        "${Constants.baseUrl}/anime/season/$year/$season?limit=20&fields=id,title,main_picture,mean,start_date";

    final res = await http.get(
      Uri.parse(url),
      headers: {"X-MAL-CLIENT-ID": Constants.clientId},
    );

    if (res.statusCode != 200) throw Exception("Season error");

    final data = jsonDecode(res.body);

    return (data["data"] as List).map((item) {
      final d = item["node"];
      return Anime(
        id: d["id"],
        title: d["title"],
        image: d["main_picture"]?["large"],
        mean: d["mean"]?.toDouble(),
        year: d["start_date"] != null
            ? DateTime.parse(d["start_date"]).year
            : null,
      );
    }).toList();
  }

  // DETAIL
  static Future<AnimeDetail> getDetail(int id) async {
    final url =
        "${Constants.baseUrl}/anime/$id?fields=id,title,main_picture,mean,start_date,synopsis,genres";

    final res = await http.get(
      Uri.parse(url),
      headers: {"X-MAL-CLIENT-ID": Constants.clientId},
    );

    if (res.statusCode != 200) throw Exception("Failed to load detail");

    final d = jsonDecode(res.body);

    return AnimeDetail(
      id: d["id"],
      title: d["title"],
      image: d["main_picture"]?["large"],
      mean: d["mean"]?.toDouble(),
      synopsis: d["synopsis"],
      year: d["start_date"] != null
          ? DateTime.parse(d["start_date"]).year
          : null,
      genres: (d["genres"] as List?)?.map((g) => g["name"] as String).toList() ?? [],
    );
  }
}
