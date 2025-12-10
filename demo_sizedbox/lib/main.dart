import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Card',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card Demo'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: const Center(
          child: InfoCard(),
        ),
      ),
    );
  }
}

// Widget Card
class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            leading: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 40,
            ),
            title: Text(
              'Taman Nasional Bromo Tengger Semeru',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Jawa Timur, Indonesia'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Icon(Icons.map),
                ),
                const SizedBox(width: 10), // jarak antar tombol
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Icon(Icons.phone),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
