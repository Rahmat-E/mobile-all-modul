import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: const Text("Ini Halaman Home"),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Banyak aplikasi memiliki beberapa layar untuk menampilkan informasi yang berbeda. "
                    "Contohnya, ada layar produk, dan ketika pengguna menekan produk, akan muncul layar "
                    "dengan detail produk tersebut.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/icon/house.png", // tambahkan gambar rumah ke folder assets
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "Pertama, kita perlu membuat dua halaman atau 'routes' yang ingin ditampilkan. "
                    "Selanjutnya, kita gunakan perintah Navigator.push() untuk berpindah dari halaman "
                    "pertama ke halaman kedua. Terakhir, kita bisa kembali dari halaman kedua ke halaman "
                    "pertama menggunakan Navigator.pop().",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tujuan');
                },
                child: const Text("Ke halaman tujuan >"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
