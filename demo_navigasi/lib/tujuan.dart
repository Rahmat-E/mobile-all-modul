import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      appBar: AppBar(
        title: const Text("Ini Halaman Tujuan"),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). "
                    "Metode push() akan menambahkan Route ke dalam tumpukan Route yang dikelola oleh Navigator. "
                    "Route ini dapat dibuat secara kustom atau menggunakan MaterialPageRoute, "
                    "yang memiliki animasi transisi sesuai dengan platform yang digunakan.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/icon/beach.png", // tambahkan gambar pantai ke folder assets
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "Untuk menutup halaman kedua dan kembali ke halaman pertama, gunakan metode Navigator.pop(). "
                    "Metode pop() akan menghapus Route saat ini dari tumpukan Route yang dikelola oleh Navigator.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("< Kembali ke home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
