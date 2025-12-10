import 'package:flutter/material.dart';
import '../models/anime.dart';

class FavoritesPage extends StatelessWidget {
  final List<Anime> favorites;
  final void Function(int) onOpenDetail;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onOpenDetail,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("Belum ada anime favorit."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (_, i) {
          final a = favorites[i];
          return InkWell(
            onTap: () => onOpenDetail(a.id),
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      a.image ?? "",
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          "Score: ${a.mean ?? '-'}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Year: ${a.year ?? '-'}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
