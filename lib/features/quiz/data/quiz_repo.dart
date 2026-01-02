import 'quiz_model.dart';

class QuizRepository {
  Future<List<Quiz>> fetchQuizzes() async {
    // ✅ Simulasi loading ringan
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      // ───────────────────────────────────────────────
      // 🇮🇩 KUIS 1: BAHASA JAWA
      // ───────────────────────────────────────────────
      Quiz(
        id: 1,
        title: 'Bahasa Jawa Dasar',
        description:
            'Uji pengetahuanmu tentang ungkapan sehari-hari dalam bahasa Jawa.',
        questions: [
          Question(
            question: 'Apa arti dari "matur nuwun"?',
            options: [
              'Selamat pagi',
              'Terima kasih',
              'Selamat tinggal',
              'Maaf',
            ],
            answer: 1,
          ),
          Question(
            question: 'Bagaimana menyapa orang tua di pagi hari?',
            options: [
              'Sugeng enjang',
              'Sugeng siang',
              'Sugeng sonten',
              'Sugeng ndalu',
            ],
            answer: 0,
          ),
        ],
      ),

      // ───────────────────────────────────────────────
      // 🇮🇩 KUIS 2: SEJARAH MAJAPAHIT
      // ───────────────────────────────────────────────
      Quiz(
        id: 2,
        title: 'Kerajaan Majapahit',
        description:
            'Pelajari kejayaan kerajaan Hindu-Buddha terbesar di Nusantara.',
        questions: [
          Question(
            question: 'Siapa patih yang mengucapkan Sumpah Palapa?',
            options: [
              'Raden Wijaya',
              'Gajah Mada',
              'Hayam Wuruk',
              'Arya Damar',
            ],
            answer: 1,
          ),
        ],
      ),
    ];
  }
}
