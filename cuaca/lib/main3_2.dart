import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Malang',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '25°',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CuacaCard(
                    hari: 'Minggu',
                    icon: Icons.sunny,
                    suhu: '20°C',
                  ),
                  CuacaCard(
                    hari: 'Senin',
                    icon: Icons.cloudy_snowing,
                    suhu: '23°C',
                  ),
                  CuacaCard(
                    hari: 'Selasa',
                    icon: Icons.cloud,
                    suhu: '22°C',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CuacaCard extends StatelessWidget {
  final String hari;
  final IconData icon;
  final String suhu;

  const CuacaCard({
    super.key,
    required this.hari,
    required this.icon,
    required this.suhu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(hari),
        const SizedBox(height: 5),
        Icon(
          icon,
          size: 40,
          color: Colors.black,
        ),
        const SizedBox(height: 5),
        Text(suhu),
      ],
    );
  }
}
