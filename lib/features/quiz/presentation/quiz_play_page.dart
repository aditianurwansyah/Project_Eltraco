import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_model.dart';

class QuizPlayPage extends StatefulWidget {
  final Quiz? quiz;

  const QuizPlayPage({super.key, required this.quiz});

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int _score = 0;
  bool _answered = false;

  /// POINT 3: LOGIKA SIMPAN SKOR DAN NAMA (SANGAT DETAIL)
  /// Fungsi ini menyimpan riwayat sesi kuis sekaligus mengupdate skor total di Leaderboard.
  Future<void> _handleFinishQuiz() async {
    final quiz = widget.quiz!;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 1. Mengambil Identitas Asli User (DisplayName atau Email)
      final String displayName =
          user.displayName ?? user.email?.split('@')[0] ?? "Pemain";

      try {
        // Menggunakan Write Batch agar data 'history' dan 'leaderboard' tersimpan secara atomik
        final batch = FirebaseFirestore.instance.batch();

        // 2. Simpan ke koleksi 'history' (Riwayat setiap kali kuis selesai dimainkan)
        final historyRef = FirebaseFirestore.instance
            .collection('history')
            .doc();
        batch.set(historyRef, {
          'uid': user.uid,
          'name': displayName,
          'quizTitle': quiz.title,
          'score': _score,
          'totalQuestions': quiz.questions.length,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // 3. Update koleksi 'leaderboard' (Pusat Kompetisi Global)
        // Menggunakan doc(user.uid) agar setiap akun hanya memiliki satu entri kumulatif
        final leaderboardRef = FirebaseFirestore.instance
            .collection('leaderboard')
            .doc(user.uid);

        batch.set(leaderboardRef, {
          'name': displayName, // Nama yang akan muncul di Papan Peringkat
          'totalScore': FieldValue.increment(_score), // Skor akumulasi otomatis
          'lastPlayed': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Eksekusi semua perubahan sekaligus
        await batch.commit();
      } catch (e) {
        debugPrint('Gagal sinkronisasi skor ke leaderboard: $e');
      }
    }

    // Navigasi kembali setelah proses database selesai
    if (mounted) {
      context.go('/quizzes');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selesai! Skor $_score ditambahkan ke peringkat Anda.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _answer(int choice) async {
    if (_answered) return;
    setState(() => _answered = true);

    final quiz = widget.quiz!;
    // Validasi apakah indeks pilihan user (choice) sama dengan indeks jawaban benar (answer)
    final correct = choice == quiz.questions[_index].answer;

    if (correct) _score++;

    // Tampilkan animasi Lottie feedback (Centang/Salah)
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: SizedBox(
          height: 180,
          child: Lottie.asset(
            correct
                ? 'assets/lottie/Checkmark.json'
                : 'assets/lottie/wrong.json',
            repeat: false,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );

    // Cek apakah masih ada soal berikutnya
    if (_index < quiz.questions.length - 1) {
      setState(() {
        _index++;
        _answered = false;
      });
    } else {
      // Jika soal sudah habis, simpan data ke Firestore
      await _handleFinishQuiz();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    if (quiz == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Data kuis tidak ditemukan, kembali'),
          ),
        ),
      );
    }

    final q = quiz.questions[_index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${_index + 1} dari ${quiz.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indikator kemajuan kuis
            LinearProgressIndicator(
              value: (_index + 1) / quiz.questions.length,
              color: Colors.blueAccent,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 32),
            Text(
              q.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // Generate tombol opsi jawaban secara dinamis
            ...List.generate(q.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _answered ? null : () => _answer(i),
                  child: Text(
                    q.options[i],
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
