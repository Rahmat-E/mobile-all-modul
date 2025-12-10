import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Music'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            "Pemutar Musik",
            style: TextStyle(fontSize: 20),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
          color: Colors.black54,
          child: Row(
            children: [
              const Expanded(
                child: Icon(Icons.shuffle, color: Colors.white),
              ),
              const Expanded(
                child: Icon(Icons.skip_previous, color: Colors.white),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Icon(Icons.play_circle_fill,
                    color: Colors.white, size: 50),
              ),
              const Expanded(
                child: Icon(Icons.skip_next, color: Colors.white),
              ),
              const Expanded(
                child: Icon(Icons.repeat, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
