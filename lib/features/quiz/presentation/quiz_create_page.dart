import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_eltraco/features/quiz/data/quiz_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizCreatePage extends StatefulWidget {
  const QuizCreatePage({super.key});

  @override
  State<QuizCreatePage> createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  int _jumlahSoal = 5;
  List<Question> _listSoal = [];

  @override
  void initState() {
    super.initState();
    _updateListSoal();
  }

  void _updateListSoal() {
    setState(() {
      _listSoal = List.generate(
        _jumlahSoal,
        (index) => Question(question: '', options: ['', '', '', ''], answer: 0),
      );
    });
  }

  Future<void> _saveQuiz() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul kuis tidak boleh kosong!")),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('quizzes').add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'creatorId': user?.uid,
        'creatorName': user?.displayName ?? user?.email?.split('@')[0],
        'questions': _listSoal
            .map(
              (q) => {
                'questionText': q.question,
                'options': q.options,
                'answer': q.answer,
              },
            )
            .toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kuis berhasil dipublikasikan secara global!"),
          ),
        );
        context.pop();
      }
    } catch (e) {
      debugPrint("Error saat menyimpan kuis: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Kuis Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Kuis',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<int>(
              value: _jumlahSoal,
              decoration: const InputDecoration(
                labelText: 'Jumlah Nomor Soal',
                border: OutlineInputBorder(),
              ),
              items: [1, 5, 10, 20].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value Soal'),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _jumlahSoal = val!;
                  _updateListSoal();
                });
              },
            ),
            const Divider(height: 40, thickness: 2),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _listSoal.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Masukkan Pertanyaan...',
                            prefixIcon: Icon(Icons.help_outline),
                          ),
                          // Perbaikan update state pertanyaan
                          onChanged: (v) => _listSoal[index].question = v,
                        ),
                        const SizedBox(height: 15),

                        ...List.generate(4, (i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText:
                                    'Opsi ${String.fromCharCode(65 + i)}',
                                prefixIcon: const Icon(Icons.arrow_right),
                              ),
                              // Perbaikan update state opsi
                              onChanged: (v) => _listSoal[index].options[i] = v,
                            ),
                          );
                        }),

                        const SizedBox(height: 15),

                        DropdownButtonFormField<int>(
                          value: _listSoal[index].answer,
                          decoration: InputDecoration(
                            labelText: 'Pilih Jawaban yang Benar',
                            filled: true,
                            // PERBAIKAN: Gunakan warna indigo yang sangat transparan
                            // agar teks tetap terlihat jelas
                            fillColor: Colors.indigo.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: List.generate(4, (i) {
                            return DropdownMenuItem(
                              value: i,
                              child: Text(
                                'Opsi ${String.fromCharCode(65 + i)}',
                              ),
                            );
                          }),
                          onChanged: (val) {
                            setState(() {
                              _listSoal[index].answer = val!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveQuiz,
              icon: const Icon(Icons.cloud_upload),
              label: const Text('PUBLIKASIKAN KUIS'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
