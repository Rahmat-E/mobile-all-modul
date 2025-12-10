import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flexible Example'),
        ),
        body: const Center(
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: KotakBiruJempolKecil(),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: KotakBiruJempolKecil(),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: KotakBiruJempolKecil(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KotakBiruJempolKecil extends StatelessWidget {
  const KotakBiruJempolKecil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8), // biar nggak dempet
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.thumb_up,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
