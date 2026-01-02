import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Eltraco'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🪔 Ilustrasi simbolik (opsional: ganti dengan AssetImage jika ada)
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isDark ? Colors.indigo[900] : Colors.indigo[100],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.quiz_outlined,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 🌟 Judul utama
            const Text(
              'Eltraco: Kuis Kekayaan Nusantara',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // 📝 Deskripsi
            Text(
              'Aplikasi ini dirancang untuk melestarikan dan memperkenalkan kekayaan budaya, sejarah, bahasa daerah, dan kearifan lokal Indonesia melalui kuis interaktif.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // 📋 Daftar fitur
            _buildSectionTitle(context, 'Fitur Utama'),
            _buildInfoTile(
              context,
              Icons.email_outlined,
              'Login Cepat',
              'Gunakan email apa saja untuk masuk — tanpa registrasi rumit.',
            ),
            _buildInfoTile(
              context,
              Icons.score_outlined,
              'Skor Real-Time',
              'Nilai kuis langsung tersimpan dan muncul di Leaderboard.',
            ),
            _buildInfoTile(
              context,
              Icons.history_outlined,
              'Riwayat Kuis',
              'Lihat kembali soal dan jawaban Anda kapan saja.',
            ),
            _buildInfoTile(
              context,
              Icons.dark_mode_outlined,
              'Mode Tampilan',
              'Ganti ke mode gelap/terang sesuai kenyamanan Anda.',
            ),

            const SizedBox(height: 32),

            // 🧭 Petunjuk penggunaan
            _buildSectionTitle(context, 'Cara Bermain'),
            _buildInstructionStep(
              context,
              1,
              'Pilih kategori kuis (misal: Bahasa Daerah, Sejarah Lokal).',
            ),
            _buildInstructionStep(
              context,
              2,
              'Jawab pertanyaan dengan memilih opsi yang benar.',
            ),
            _buildInstructionStep(
              context,
              3,
              'Dapatkan skor berdasarkan kecepatan dan ketepatan jawaban.',
            ),
            _buildInstructionStep(
              context,
              4,
              'Lihat peringkat Anda di Leaderboard nasional!',
            ),

            const SizedBox(height: 32),

            // 👥 Dukungan & kontak
            _buildSectionTitle(context, 'Butuh Bantuan?'),
            Center(
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // 📄 Footer
            Divider(color: theme.colorScheme.outline.withOpacity(0.3)),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '© ${DateTime.now().year} Eltraco • Versi 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionStep(BuildContext context, int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
