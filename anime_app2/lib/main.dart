import 'package:flutter/material.dart';
import 'pages/root_screen.dart';
import 'pages/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anime App",

      // Halaman pertama
      home: const RootScreen(),

      // ROUTES WAJIB ADA
      routes: {
        "/detail": (context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return DetailPage(animeId: id);
        },
      },
    );
  }
}
