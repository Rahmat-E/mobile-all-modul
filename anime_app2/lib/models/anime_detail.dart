class AnimeDetail {
  final int id;
  final String title;
  final String? image;
  final double? mean;
  final String? synopsis;
  final int? year;
  final List<String> genres;

  AnimeDetail({
    required this.id,
    required this.title,
    this.image,
    this.mean,
    this.synopsis,
    this.year,
    required this.genres,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> d) {
    return AnimeDetail(
      id: d["id"],
      title: d["title"],
      image: d["main_picture"]?["large"],
      mean: d["mean"]?.toDouble(),
      synopsis: d["synopsis"],
      year: d["start_date"] != null
          ? DateTime.parse(d["start_date"]).year
          : null,
      genres: (d["genres"] as List?)
          ?.map((g) => g["name"] as String)
          .toList()
          ?? [],
    );
  }
}
