import 'package:flutter/material.dart';
import 'package:flutter_eltraco/core/notifiers/theme_notifier.dart';

// ✅ Ambil instance global
final themeNotifier = ThemeNotifier();

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _dark;

  @override
  void initState() {
    super.initState();
    // ✅ Ambil nilai awal dari tema saat ini (setelah build)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _dark = Theme.of(context).brightness == Brightness.dark;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔁 Switch untuk mode gelap
            SwitchListTile(
              title: const Text('Mode Gelap'),
              subtitle: const Text(
                'Aktifkan tampilan gelap untuk mengurangi kelelahan mata',
              ),
              value: _dark,
              onChanged: (bool? value) {
                if (value == null) return;
                setState(() {
                  _dark = value;
                });
                // ✅ LANGSUNG UBAH TEMA GLOBAL
                themeNotifier.toggle(value);
              },
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Preferensi Anda akan disimpan secara lokal.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Versi 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
