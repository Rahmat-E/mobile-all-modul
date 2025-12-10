import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen_arguments.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // ambil data arguments yang dikirim dari Home
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    // transparan untuk status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29), // merah sesuai modul
      appBar: AppBar(
        title: Text(args.title),
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar cover
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    args.cover,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                // Judul
                Text(
                  args.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 47, 72),
                  ),
                ),
                const SizedBox(height: 10),
                // Deskripsi pendek
                Text(
                  args.shortDesc,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 47, 72),
                  ),
                ),
                const SizedBox(height: 20),
                // Deskripsi panjang
                Text(
                  args.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 47, 72),
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 25),
                // Tombol kembali
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0881c9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 15,
                          color: Color(0xFFF4FBFB),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Kembali ke game',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFF4FBFB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
