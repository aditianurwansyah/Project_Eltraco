import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/quiz_model.dart';

class QuizPlayPage extends StatefulWidget {
  final Quiz? quiz; // ✅ nullable

  const QuizPlayPage({super.key, required this.quiz});

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int _score = 0;
  bool _answered = false;

  void _answer(int choice) async {
    if (_answered) return;
    setState(() => _answered = true);

    final quiz = widget.quiz!;
    final correct = choice == quiz.questions[_index].answer;
    if (correct) _score++;

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
            animate: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );

    if (_index < quiz.questions.length - 1) {
      setState(() {
        _index++;
        _answered = false;
      });
    } else {
      // ✅ Simpan ke Firestore
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('scores').add({
            'uid': user.uid,
            'userName': user.displayName ?? 'Pengguna',
            'quizTitle': quiz.title,
            'score': _score,
            'total': quiz.questions.length,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      } catch (e) {
        debugPrint('Error simpan skor: $e');
      }

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selesai! Skor: $_score/${quiz.questions.length}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Kembali'),
          ),
        ),
      );
    }

    final q = quiz.questions[_index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${_index + 1}/${quiz.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              q.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(q.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: _answered ? null : () => _answer(i),
                  child: Text(q.options[i]),
                ),
              );
            }),
            const Spacer(),
            LinearProgressIndicator(
              value: (_index + 1) / quiz.questions.length,
            ),
          ],
        ),
      ),
    );
  }
}
