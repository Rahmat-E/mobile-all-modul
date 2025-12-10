import 'package:flutter/material.dart';
import '../services/anime_api.dart';
import '../services/anime_api.dart';
import '../models/anime.dart';
import '../widgets/shimmer_box.dart';
import '../widgets/error_widget.dart' as err;
import '../widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  final void Function(int) onOpenDetail;

  const HomePage({
    super.key,
    required this.onOpenDetail,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Anime>> futureRanking;

  @override
  void initState() {
    super.initState();
    futureRanking = AnimeApi.getTopAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Anime Ranking")),
      body: FutureBuilder<List<Anime>>(
        future: futureRanking,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return _buildShimmerGrid();
          }

          if (snap.hasError) {
            return err.AppError(
              message: "Gagal memuat data, cek koneksi internet kamu.",
              onRetry: () {
                setState(() {
                  futureRanking = AnimeApi.getTopAnime();
                });
              },
            );
          }

          final list = snap.data!;
          return _buildRealGrid(list);
        },
      ),
    );
  }

  // 🔥 SHIMMER GRID UNTUK LOADING
  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(height: 180, width: double.infinity, radius: 12),
            const SizedBox(height: 8),
            ShimmerBox(height: 16, width: 120),
          ],
        );
      },
    );
  }

  // 🔥 GRID ASLI DARI API
  Widget _buildRealGrid(List<Anime> list) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final a = list[i];
        return GestureDetector(
          onTap: () => widget.onOpenDetail(a.id),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GAMBAR
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  a.image ?? "",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                a.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
