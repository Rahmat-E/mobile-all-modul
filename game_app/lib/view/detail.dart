import 'package:flutter/material.dart'; // 1
import 'package:game_app/viewmodel/fetchgame.dart'; // 1025
import 'package:game_app/model/detailgame.dart'; // 1026
import 'package:readmore/readmore.dart'; // 1027

// 946
class Detail extends StatelessWidget {
  final int gameTerpilih;
  const Detail({super.key, required this.gameTerpilih});

  // 1032
  Future<DetailGame> fetchData() async {
    // 1030
    final jsonData = await fetchDataFromAPI(gameTerpilih);
    // 1035
    return DetailGame.fromJson(jsonData);
  }

  // 1042
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: FutureBuilder<DetailGame>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Data tidak tersedia'));
            } else {
              final game = snapshot.data!;
              return Column(
                children: [
                  // Header (Image and Back Button) // 1049
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          child: Image.network(
                            game.thumbnail,
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        ),
                        Positioned(
                          top: 25,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Minimum System Requirements // 1059
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  'Minimum System Requirements',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  _requirementRow('OS', game.minimum_system_requirements.os),
                                  _requirementRow('Processor',
                                      game.minimum_system_requirements.processor),
                                  _requirementRow('Memory',
                                      game.minimum_system_requirements.memory),
                                  _requirementRow('Graphics',
                                      game.minimum_system_requirements.graphics),
                                  _requirementRow('Storage',
                                      game.minimum_system_requirements.storage),
                                ],
                              ),

                              // Screenshot Listview Horizontal // 1070
                              Container(
                                height: 200,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    _itemList(game.screenshots[0].image),
                                    const SizedBox(width: 15),
                                    _itemList(game.screenshots[1].image),
                                    const SizedBox(width: 15),
                                    _itemList(game.screenshots[2].image),
                                  ],
                                ),
                              ),

                              // Description // 1071
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: ReadMoreText(
                                  game.description,
                                  trimLines: 2,
                                  colorClickableText: Colors.amberAccent.shade400,
                                  trimMode: TrimMode.Line,
                                  style: TextStyle(
                                      color: Colors.black54.withOpacity(0.8),
                                      height: 1.5
                                  ),
                                  trimCollapsedText: 'more',
                                  trimExpandedText: 'less',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }
      ),
    );
  }
}

// 1052
SizedBox _itemList(String url) {
  return SizedBox(
    width: 250,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    ),
  );
}

// 1063
Row _requirementRow(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 3, child: Text(title, style: TextStyle(color:
      Colors.black54.withOpacity(0.8)))),
      Expanded(flex: 1, child: Text(':', style: TextStyle(color:
      Colors.black54.withOpacity(0.8)))),
      Expanded(flex: 8, child: Text(value, style: TextStyle(color:
      Colors.black54.withOpacity(0.8)))),
    ],
  );
}