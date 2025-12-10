import 'package:flutter/material.dart';
import '../services/anime_api.dart';
import '../services/anime_api.dart';
import '../models/anime.dart';
import '../widgets/shimmer_box.dart';
import '../widgets/error_widget.dart' as err;

class SeasonPage extends StatefulWidget {
  final void Function(int) onOpenDetail;

  const SeasonPage({
    super.key,
    required this.onOpenDetail,
  });

  @override
  State<SeasonPage> createState() => _SeasonPageState();
}

class _SeasonPageState extends State<SeasonPage> {
  String selectedSeason = "winter";
  int selectedYear = DateTime.now().year;

  Future<List<Anime>>? futureSeason;

  final seasons = ["winter", "spring", "summer", "fall"];

  @override
  void initState() {
    super.initState();
    _loadSeason();
  }

  void _loadSeason() {
    setState(() {
      futureSeason = AnimeApi.getSeasonAnime(selectedYear, selectedSeason);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seasonal Anime"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          _buildFilterBar(),

          Expanded(
            child: FutureBuilder<List<Anime>>(
              future: futureSeason,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return _buildShimmerGrid();
                }

                if (snap.hasError) {
                  return err.AppError(
                    message: "Gagal mengambil data season.",
                    onRetry: _loadSeason,
                  );
                }

                final list = snap.data!;
                if (list.isEmpty) {
                  return const Center(child: Text("Tidak ada anime untuk season ini."));
                }

                return _buildRealGrid(list);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 FILTER BAR UNTUK TAHUN DAN SEASON
  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // YEAR PICKER
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: const InputDecoration(
                labelText: "Year",
                border: OutlineInputBorder(),
              ),
              items: List.generate(20, (i) {
                final year = DateTime.now().year - i;
                return DropdownMenuItem(value: year, child: Text("$year"));
              }),

              onChanged: (v) {
                selectedYear = v!;
                _loadSeason();
              },
            ),
          ),
          const SizedBox(width: 12),

          // SEASON PICKER
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedSeason,
              decoration: const InputDecoration(
                labelText: "Season",
                border: OutlineInputBorder(),
              ),
              items: seasons
                  .map((s) => DropdownMenuItem(value: s, child: Text(s.toUpperCase())))
                  .toList(),
              onChanged: (v) {
                selectedSeason = v!;
                _loadSeason();
              },
            ),
          ),
        ],
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

  // 🔥 GRID ASLI BERDASARKAN SEASON
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
              // IMAGE
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
