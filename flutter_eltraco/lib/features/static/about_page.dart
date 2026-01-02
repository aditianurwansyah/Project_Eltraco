import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // ✅
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Eltraco adalah aplikasi kuis digital yang bertujuan melestarikan kekayaan budaya, sejarah, dan bahasa daerah Indonesia.\n\nDikembangkan oleh AditiaN untuk mendukung pembelajaran berbasis kearifan lokal.',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
