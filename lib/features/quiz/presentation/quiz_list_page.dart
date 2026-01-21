import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_eltraco/features/quiz/data/quiz_model.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user yang sedang login untuk menampilkan identitas di Drawer
    final user = FirebaseAuth.instance.currentUser;
    final String displayUserName =
        user?.displayName ?? user?.email?.split('@')[0] ?? "Pengguna";

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Kuis'), centerTitle: true),

      // Floating Action Button untuk navigasi ke pembuatan kuis
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/create-quiz'),
        label: const Text('Buat Kuis'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              accountName: Text(
                displayUserName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user?.email ?? ""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blueAccent, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('Buat Kuis Baru'),
              onTap: () {
                Navigator.pop(context);
                context.push('/create-quiz');
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.pop(context);
                context.push('/leaderboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat'),
              onTap: () {
                Navigator.pop(context);
                context.push('/history');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
                context.push('/profile');
              },
            ),
            const Divider(),
            // TETAP: Menu Pengaturan dan Tentang/Info tidak berubah
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () => context.push('/settings'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: () => context.push('/about'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Info'),
              onTap: () => context.push('/info'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
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

      // POINT 2 PERBAIKAN: Pengambilan Daftar Kuis Global Real-time
      body: StreamBuilder<QuerySnapshot>(
        // Mengambil semua dokumen kuis dari koleksi 'quizzes' secara global.
        // Tanpa filter .where('uid'), sehingga akun baru bisa melihat kuis akun lama.
        stream: FirebaseFirestore.instance
            .collection('quizzes')
            .orderBy(
              'createdAt',
              descending: true,
            ) // Mengurutkan berdasarkan waktu pembuatan
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Gagal memuat kuis: ${snapshot.error}\n\nPastikan Index Firestore sudah dibuat.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada kuis tersedia secara global.\nKlik "Buat Kuis" untuk menjadi yang pertama!',
                textAlign: TextAlign.center,
              ),
            );
          }

          final quizDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: quizDocs.length,
            itemBuilder: (context, index) {
              final data = quizDocs[index].data() as Map<String, dynamic>;

              try {
                // Konversi data Map Firestore ke Model Quiz
                final q = Quiz.fromMap(data);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.quiz, color: Colors.white),
                    ),
                    title: Text(
                      q.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Menampilkan Nama Pembuat agar terlihat interaksi antar akun
                    subtitle: Text(
                      'Oleh: ${data['creatorName'] ?? "Anonim"}\n${q.description}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/quiz', extra: q);
                    },
                  ),
                );
              } catch (e) {
                // Melewati item jika terjadi error pada mapping data tertentu
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
