import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Papan Peringkat Global'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/quizzes'),
        ),
      ),
      body: const _LeaderboardBody(),
    );
  }
}

class _LeaderboardBody extends StatelessWidget {
  const _LeaderboardBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // POINT 4 DETAIL: Mengambil data dari koleksi 'leaderboard'
      // Data diurutkan berdasarkan 'totalScore' secara descending (terbesar ke terkecil)
      stream: FirebaseFirestore.instance
          .collection('leaderboard')
          .orderBy('totalScore', descending: true)
          .limit(50)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(
            child: Text('Belum ada data peringkat. Ayo mainkan kuis!'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data();

            // Mengambil nama asli dan skor total yang sudah disimpan
            final String name = data['name'] ?? 'Pemain';
            final int totalScore = (data['totalScore'] ?? 0).toInt();

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              elevation: index < 3 ? 4 : 1, // Highlight untuk Top 3
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: _buildRankBadge(index + 1, theme),
                title: Text(
                  name, // Menampilkan nama asli pengguna
                  style: TextStyle(
                    fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$totalScore',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w900, // Perbaikan dari error .black
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const Text(
                      'POIN',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRankBadge(int rank, ThemeData theme) {
    Color color;
    if (rank == 1)
      color = Colors.amber.shade700;
    else if (rank == 2)
      color = Colors.grey.shade500;
    else if (rank == 3)
      color = Colors.brown.shade400;
    else
      color = theme.colorScheme.surfaceVariant;

    return CircleAvatar(
      backgroundColor: color,
      radius: 18,
      child: Text(
        rank <= 3 ? '🏆' : '$rank',
        style: TextStyle(
          color: rank <= 3 ? Colors.white : theme.colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
