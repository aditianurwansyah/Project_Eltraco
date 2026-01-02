import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController(text: 'test@demo.com');
  final _pass = TextEditingController(text: '123456');
  bool _loading = false;

  // ✅ Validasi input sederhana
  bool _validateInput(String email, String password) {
    if (email.trim().isEmpty || !email.contains('@')) {
      _showError('Email tidak valid');
      return false;
    }
    if (password.trim().length < 6) {
      _showError('Password minimal 6 karakter');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _login() async {
    if (!_validateInput(_email.text, _pass.text)) return;

    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );
      if (mounted) context.go('/quizzes');
    } on FirebaseAuthException catch (e) {
      String msg = 'Login gagal';
      if (e.code == 'user-not-found') msg = 'Email belum terdaftar';
      if (e.code == 'wrong-password') msg = 'Password salah';
      _showError(msg);
    } catch (e) {
      _showError('Terjadi kesalahan: $e');
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _signUp() async {
    if (!_validateInput(_email.text, _pass.text)) return;

    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );
      if (mounted) context.go('/quizzes');
    } on FirebaseAuthException catch (e) {
      String msg = 'Pendaftaran gagal';
      if (e.code == 'email-already-in-use') msg = 'Email sudah digunakan';
      if (e.code == 'weak-password') msg = 'Password terlalu lemah';
      _showError(msg);
    } catch (e) {
      _showError('Terjadi kesalahan: $e');
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ✅ Perbaikan path Lottie (harus rename file jadi lowercase + underscore)
              SizedBox(
                height: 180,
                child: Lottie.asset(
                  'assets/animations/login_and_sign_up.json', // ← SESUAIKAN NAMA FILE!
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 80, color: Colors.red),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Masuk'),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _signUp, // ← Gunakan fungsi terpisah
                child: const Text('Daftar baru'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
