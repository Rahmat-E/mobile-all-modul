import 'package:flutter/material.dart';
import '../models/anime_detail.dart';
import '../services/anime_api.dart';
import '../widgets/shimmer_box.dart';
import '../widgets/error_widget.dart' as err;

class DetailPage extends StatefulWidget {
  final int animeId;

  const DetailPage({
    super.key,
    required this.animeId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<AnimeDetail> futureDetail;

  @override
  void initState() {
    super.initState();
    futureDetail = AnimeApi.getDetail(widget.animeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AnimeDetail>(
        future: futureDetail,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return _buildShimmer();
          }

          if (snap.hasError) {
            return err.AppError(
              message: "Gagal memuat detail anime.",
              onRetry: () {
                setState(() {
                  futureDetail = AnimeApi.getDetail(widget.animeId);
                });
              },
            );
          }

          final anime = snap.data!;
          return _buildRealDetail(anime);
        },
      ),
    );
  }

  // ============================================================
  // 🔥 SHIMMER UI SAAT LOADING
  // ============================================================
  Widget _buildShimmer() {
    return ListView(
      children: [
        ShimmerBox(height: 300, width: double.infinity, radius: 0),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(height: 22, width: 260),
              const SizedBox(height: 12),

              ShimmerBox(height: 16, width: 140),
              const SizedBox(height: 20),

              ...List.generate(
                6,
                    (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ShimmerBox(height: 12, width: double.infinity),
                ),
              ),
              ShimmerBox(height: 12, width: 200),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 🔥 REAL DETAIL PAGE (FINAL FIX)
  // ============================================================
  Widget _buildRealDetail(AnimeDetail a) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              a.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  a.image ?? "",
                  fit: BoxFit.cover,
                ),
                Container(color: Colors.black26),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  a.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),

                // Rating + Year
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text("${a.mean ?? '-'} / 10"),
                    const SizedBox(width: 20),
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 6),
                    Text(a.year?.toString() ?? "-"),
                  ],
                ),

                const SizedBox(height: 24),

                // Synopsis
                const Text(
                  "Synopsis",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  a.synopsis ?? "-",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(height: 1.4),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        )
      ],
    );
  }
}
