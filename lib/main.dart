import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

// 1. PASTIKAN SEMUA HALAMAN DI-IMPORT
import 'features/quiz/data/quiz_model.dart';
import 'features/quiz/presentation/quiz_list_page.dart';
import 'features/quiz/presentation/quiz_play_page.dart';
import 'features/quiz/presentation/quiz_create_page.dart';
import 'features/leaderboard/presentation/leaderboard_page.dart';
import 'features/profile/presentation/profile_page.dart';
import 'features/history/presentation/history_page.dart';
import 'features/settings/presentation/settings_page.dart';
import 'features/static/about_page.dart';
import 'features/static/info_page.dart';
import 'features/auth/presentation/login_page.dart';
import 'firebase_options.dart';

// Notifier untuk tema aplikasi
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

class AppRouter {
  static late GoRouter instance;

  static Future<void> init() async {
    instance = GoRouter(
      initialLocation: '/login',
      routes: [
        // Rute Login
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

        // Rute Daftar Kuis (Halaman Utama setelah Login)
        GoRoute(
          path: '/quizzes',
          builder: (context, state) => const QuizListPage(),
        ),

        // 2. RUTE BUAT KUIS
        GoRoute(
          path: '/create-quiz',
          builder: (context, state) => const QuizCreatePage(),
        ),

        // 3. RUTE MENU DRAWER & KOMPETISI
        GoRoute(
          path: '/leaderboard',
          builder: (context, state) => const LeaderboardPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
        GoRoute(path: '/info', builder: (context, state) => const InfoPage()),

        // Rute untuk menjalankan kuis (menggunakan extra untuk mengirim data objek Quiz)
        GoRoute(
          path: '/quiz',
          builder: (context, state) {
            final quiz = state.extra as Quiz?;
            if (quiz == null) return const QuizListPage();
            return QuizPlayPage(quiz: quiz);
          },
        ),
      ],

      // Logika Redirect: Melindungi rute agar tidak bisa diakses jika belum login
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final isLoggingIn = state.uri.path == '/login';

        if (user == null) {
          return isLoggingIn ? null : '/login';
        }

        if (isLoggingIn) {
          return '/quizzes';
        }

        return null;
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inisialisasi Router
  await AppRouter.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan ValueListenableBuilder agar tema bisa berganti secara dinamis
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp.router(
          title: 'Eltraco Quiz',
          routerConfig: AppRouter.instance,
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.indigo,
          ),
        );
      },
    );
  }
}
