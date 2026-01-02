import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

// Notifier
import 'core/notifiers/theme_notifier.dart';

// Model
import 'features/quiz/data/quiz_model.dart';

// Halaman
import 'features/auth/presentation/login_page.dart';
import 'features/quiz/presentation/quiz_list_page.dart';
import 'features/quiz/presentation/quiz_play_page.dart';
import 'features/leaderboard/presentation/leaderboard_page.dart';
import 'features/profile/presentation/profile_page.dart';
import 'features/history/presentation/history_page.dart';
import 'features/settings/presentation/settings_page.dart';
import 'features/static/about_page.dart';
import 'features/static/info_page.dart';

// Firebase config
import 'firebase_options.dart';

final themeNotifier = ThemeNotifier();

class AppRouter {
  static late GoRouter instance;
  static List<Quiz> quizList = [];

  static Future<void> init() async {
    // ✅ Isi daftar kuis (bisa ganti dengan QuizRepository nanti)
    quizList = _mockQuizzes;

    instance = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
        GoRoute(path: '/quizzes', builder: (_, __) => const QuizListPage()),

        // ✅ Route utama: /quiz → pakai extra
        GoRoute(
          path: '/quiz',
          builder: (context, state) {
            final quiz = state.extra as Quiz?;
            if (quiz == null) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data kuis tidak tersedia')),
                );
              }
              return const QuizListPage();
            }
            return QuizPlayPage(quiz: quiz);
          },
        ),

        // 🔁 Opsional: deep link /quiz/1
        GoRoute(
          path: '/quiz/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '0');
            if (id == null) return const QuizListPage();
            final quiz = AppRouter.quizList.firstWhereOrNull((q) => q.id == id);
            if (quiz == null) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kuis tidak ditemukan')),
                );
              }
              return const QuizListPage();
            }
            return QuizPlayPage(quiz: quiz);
          },
        ),

        GoRoute(
          path: '/leaderboard',
          builder: (_, __) => const LeaderboardPage(),
        ),
        GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
        GoRoute(path: '/history', builder: (_, __) => const HistoryPage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
        GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
        GoRoute(path: '/info', builder: (_, __) => const InfoPage()),
      ],
      redirect: (context, state) async {
        final user = FirebaseAuth.instance.currentUser;
        final isLogin = state.uri.path == '/login';
        return user == null
            ? (isLogin ? null : '/login')
            : (isLogin ? '/quizzes' : null);
      },
      refreshListenable: themeNotifier,
    );

    FirebaseAuth.instance.authStateChanges().listen((_) => instance.refresh());
  }

  // ✅ Data lokal — ganti dengan QuizRepository().fetchQuizzes() nanti
  static final List<Quiz> _mockQuizzes = [
    Quiz(
      id: 1,
      title: 'Bahasa Jawa Dasar',
      description: 'Uji pengetahuanmu tentang bahasa Jawa.',
      questions: [
        Question(
          question: 'Apa arti "matur nuwun"?',
          options: ['Selamat pagi', 'Terima kasih', 'Selamat tinggal', 'Maaf'],
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
        Question(
          question: 'Siapa patih yang bersumpah Palapa?',
          options: ['Raden Wijaya', 'Gajah Mada', 'Hayam Wuruk', 'Arya Damar'],
          answer: 1,
        ),
        Question(
          question: '“Inggih” artinya …',
          options: ['Tidak', 'Ya', 'Mungkin', 'Tentu'],
          answer: 1,
        ),
        Question(
          question: 'Apa bahasa Jawa-ngoko dari “makan”?',
          options: ['Mangan', 'Mlaku', 'Turu', 'Dahar'],
          answer: 0,
        ),
        Question(
          question: '“Awaké kabèh” artinya …',
          options: ['Sebagian', 'Mereka berdua', 'Semuanya', 'Beberapa'],
          answer: 2,
        ),
      ],
    ),
    Quiz(
      id: 2,
      title: 'Sejarah Majapahit',
      description: 'Pelajari kejayaan kerajaan Nusantara.',
      questions: [
        Question(
          question: 'Siapa patih yang bersumpah Palapa?',
          options: ['Raden Wijaya', 'Gajah Mada', 'Hayam Wuruk', 'Arya Damar'],
          answer: 1,
        ),
      ],
    ),
  ];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppRouter.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp.router(
          title: 'Eltraco Quiz',
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
          darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
          themeMode: themeMode,
          routerConfig: AppRouter.instance,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
