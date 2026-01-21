import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key}); // Gunakan super key terbaru

  @override
  Widget build(BuildContext context) {
    // Ambil UID user yang sedang aktif
    final user = FirebaseAuth.instance.currentUser;

    // Jika user tidak sengaja belum login tapi masuk ke sini
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Silakan login terlebih dahulu')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Kuis Saya'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        // ✅ PERBAIKAN 1: Sesuaikan koleksi ke 'history' (seperti di QuizPlayPage)
        stream: FirebaseFirestore.instance
            .collection('history')
            .where('uid', isEqualTo: user.uid) // Filter hanya milik user ini
            .orderBy('timestamp', descending: true) // Urutan terbaru di atas
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snap.error}'));
          }

          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snap.data?.docs ?? [];

          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada riwayat kuis.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i].data() as Map<String, dynamic>;

              // ✅ PERBAIKAN 2: Pastikan nama field sesuai dengan QuizPlayPage
              final String title = d['quizTitle'] ?? 'Kuis Tanpa Judul';
              final int score = d['score'] ?? 0;
              final int total = d['totalQuestions'] ?? 0; // Sesuaikan fieldnya
              final Timestamp? time = d['timestamp'] as Timestamp?;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getScoreColor(
                      score,
                      total,
                    ).withOpacity(0.1),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: _getScoreColor(score, total),
                    ),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Skor: $score / $total'),
                  trailing: Text(
                    _formatDateTime(time),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Fungsi untuk mewarnai ikon berdasarkan hasil skor
  Color _getScoreColor(int score, int total) {
    if (total == 0) return Colors.grey;
    double ratio = score / total;
    if (ratio >= 0.8) return Colors.green;
    if (ratio >= 0.5) return Colors.orange;
    return Colors.red;
  }

  // Fungsi pembantu format tanggal
  String _formatDateTime(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year}\n${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}
