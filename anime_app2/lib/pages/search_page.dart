import 'package:flutter/material.dart';
import '../services/anime_api.dart';
import '../models/anime.dart';
import '../services/anime_api.dart';
import '../widgets/shimmer_box.dart';
import '../widgets/error_widget.dart' as err;

class SearchPage extends StatefulWidget {
  final void Function(int) onOpenDetail;

  const SearchPage({
    super.key,
    required this.onOpenDetail,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchCtrl = TextEditingController();
  Future<List<Anime>>? futureSearch;

  void _doSearch() {
    final q = searchCtrl.text.trim();
    if (q.isEmpty) return;

    setState(() {
      futureSearch = AnimeApi.searchAnime(q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Anime"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _doSearch(),
                    decoration: InputDecoration(
                      hintText: "Search anime...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: _doSearch,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          Expanded(
            child: futureSearch == null
                ? const Center(child: Text("Masukkan kata kunci untuk mencari anime."))
                : FutureBuilder<List<Anime>>(
              future: futureSearch,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return _buildShimmerList();
                }

                if (snap.hasError) {
                  return err.AppError(
                    message: "Gagal mengambil data. Periksa koneksi internet.",
                    onRetry: _doSearch,
                  );
                }

                final list = snap.data!;
                if (list.isEmpty) {
                  return const Center(
                    child: Text("Tidak ditemukan anime untuk kata kunci ini."),
                  );
                }

                return _buildResultList(list);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 SHIMMER LIST SAAT LOADING
  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              ShimmerBox(height: 100, width: 80, radius: 12),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(height: 14, width: 200),
                    const SizedBox(height: 8),
                    ShimmerBox(height: 14, width: 150),
                    const SizedBox(height: 8),
                    ShimmerBox(height: 14, width: 180),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔥 LIST HASIL PENCARIAN
  Widget _buildResultList(List<Anime> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final a = list[i];
        return InkWell(
          onTap: () => widget.onOpenDetail(a.id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    a.image ?? "",
                    height: 100,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    a.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
