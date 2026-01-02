import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _initialize();
  }

  /// Inisialisasi asinkron: baca dari SharedPreferences
  Future<void> _initialize() async {
    final mode = await _loadFromStorage();
    // Pastikan widget masih ada sebelum update
    if (_isDisposed) return;
    value = mode;
  }

  static Future<ThemeMode> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDark') ?? false;
      return isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      // Jika error (misal: web tanpa localStorage), fallback ke light
      return ThemeMode.light;
    }
  }

  /// Ubah tema & simpan ke SharedPreferences
  Future<void> toggle(bool isDark) async {
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;

    // Simpan dulu ke storage
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', isDark);
    } catch (e) {
      // Abaikan error storage (misal: incognito mode)
    }

    // Update state
    if (!_isDisposed) {
      value = newMode;
    }
  }

  // 🔒 Hindari setState setelah dispose (penting untuk web)
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
