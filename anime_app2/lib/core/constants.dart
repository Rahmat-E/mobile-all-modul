class Constants {
  static const String clientId = "7b58c0f62fa41030463fee3ecbd4ab3b";
  static const String baseUrl = "https://api.myanimelist.net/v2";
}

class AppConstants {
  static const String baseUrl = "https://api.myanimelist.net/v2";

  // Client ID dari MyAnimeList
  static const String clientId = "7b58c0f62fa41030463fee3ecbd4ab3b";

  // Field default anime list (ranking & search)
  static const String animeFields =
      "id,title,main_picture,mean,rank,popularity,genres";

  // Field untuk detail anime
  static const String animeDetailFields =
      "id,title,main_picture,alternative_titles,start_date,end_date,"
      "synopsis,mean,rank,popularity,num_list_users,num_scoring_users,"
      "nsfw,media_type,status,genres,studios,statistics";

  // Search endpoint builder
  static String searchAnime(String q, {int limit = 20}) =>
      "$baseUrl/anime?q=$q&limit=$limit&fields=$animeFields";

  // Ranking anime
  static String ranking({String type = "all", int limit = 20}) =>
      "$baseUrl/anime/ranking?ranking_type=$type&limit=$limit&fields=$animeFields";

  // Detail anime
  static String detail(int id) =>
      "$baseUrl/anime/$id?fields=$animeDetailFields";
  static String seasonal(int year, String season) =>
      "$baseUrl/anime/season/$year/$season?limit=30&fields=mean,main_picture";


}

