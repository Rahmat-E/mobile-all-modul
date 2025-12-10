import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? title, thumbnail, shortDescription, description;
  String? genre, platform, release, cover, gameid, publisher;

  @override
  void initState() {
    super.initState();
    getGame('475');
  }

  Future<void> getGame(String id) async {
    final response = await http.get(
      Uri.parse('https://www.freetogame.com/api/game?id=$id'),
    );
    final results = jsonDecode(response.body);
    setState(() {
      gameid = id;
      title = results['title'];
      thumbnail = results['thumbnail'];
      shortDescription = results['short_description'];
      description = results['description'];
      genre = results['genre'];
      platform = results['platform'];
      publisher = results['publisher'];
      release = results['release_date'];
      cover = results['screenshots'][0]['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: const Text("Halaman Home"),
        backgroundColor: Colors.blue[900],
      ),
      body: SafeArea(
        child: Center(
          child: gameid == null
              ? const CircularProgressIndicator()
              : GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Tujuan.routeName,
                arguments: ScreenArguments(
                  cover!,
                  title!,
                  description!,
                  shortDescription!, // variabel lokal dipassing ke shortDesc
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(thumbnail!, height: 200),
                    const SizedBox(height: 15),
                    Text(title!, style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Genre: $genre"),
                            Text("Platform: $platform"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Publisher: $publisher"),
                            Text("Release: $release"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Tap card ini untuk melihat detail",
                      style: TextStyle(
                          fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
