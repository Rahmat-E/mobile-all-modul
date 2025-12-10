class Anime {
  final int id;
  final String title;
  final String? image;
  final double? mean;
  final int? year;

  Anime({
    required this.id,
    required this.title,
    this.image,
    this.mean,
    this.year,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    final pic = json["main_picture"];
    return Anime(
      id: json["id"],
      title: json["title"],
      image: pic != null ? pic["medium"] : null,
      mean: json["mean"] != null ? (json["mean"] as num).toDouble() : null,
      year: json["start_date"] != null
          ? DateTime.parse(json["start_date"]).year
          : null,
    );
  }
}
