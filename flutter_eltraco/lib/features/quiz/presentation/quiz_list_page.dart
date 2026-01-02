import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_eltraco/features/quiz/data/quiz_model.dart';
import 'package:flutter_eltraco/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Kuis')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Eltraco')),
            ListTile(
              title: const Text('Leaderboard'),
              onTap: () => context.push('/leaderboard'),
            ),
            ListTile(
              title: const Text('Profil'),
              onTap: () => context.push('/profile'),
            ),
            ListTile(
              title: const Text('Riwayat'),
              onTap: () => context.push('/history'),
            ),
            ListTile(
              title: const Text('Pengaturan'),
              onTap: () => context.push('/settings'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Tentang'),
              onTap: () => context.push('/about'),
            ),
            ListTile(
              title: const Text('Info'),
              onTap: () => context.push('/info'),
            ),
            ListTile(
              title: const Text('Keluar'),
              textColor: Colors.red,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) context.go('/login');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: AppRouter.quizList.length,
        itemBuilder: (context, index) {
          final q = AppRouter.quizList[index]; // ✅ 'q' didefinisikan di sini
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(q.title),
              subtitle: Text(q.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.push('/quiz', extra: q); // ✅ kirim data via extra
              },
            ),
          );
        },
      ),
    );
  }
}
