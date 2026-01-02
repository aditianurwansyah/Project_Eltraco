import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _LeaderboardBody());
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Papan Peringkat'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: context.pop,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => context.push('/info'),
          tooltip: 'Informasi',
        ),
      ],
    );
  }
}

class _LeaderboardBody extends StatelessWidget {
  const _LeaderboardBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('scores')
          .orderBy('score', descending: true)
          .orderBy('timestamp', descending: true)
          .limit(50)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLoading(theme);
          case ConnectionState.active:
            if (snapshot.hasError) {
              return _buildError(context, theme, snapshot.error.toString());
            }
            final docs = snapshot.data?.docs ?? [];
            return docs.isEmpty
                ? _buildEmpty(context, theme)
                : _buildList(theme, docs);
          case ConnectionState.done:
            return const Center(child: Text('Stream selesai.'));
          case ConnectionState.none:
          default:
            return _buildError(context, theme, 'Tidak ada koneksi.');
        }
      },
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 16),
          Text(
            'Memuat peringkat...',
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Perbaikan 1: Tambahkan `BuildContext context` sebagai parameter
  Widget _buildError(BuildContext context, ThemeData theme, String message) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, size: 64, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            'Gagal Memuat Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message.length > 60 ? '${message.substring(0, 60)}...' : message,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              // ✅ Sekarang context tersedia
              if (context.mounted) {
                context.go('/leaderboard');
              }
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  // ✅ Perbaikan 1: Tambahkan `BuildContext context`
  Widget _buildEmpty(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events_outlined,
                size: 40,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum Ada Skor',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Mainkan kuis pertama Anda untuk muncul di sini!',
              style: TextStyle(
                fontSize: 15,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.push('/quizzes'),
              icon: const Icon(Icons.quiz_rounded, size: 18),
              label: const Text('Mulai Kuis'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    ThemeData theme,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: docs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final doc = docs[index];
        final data = doc.data();

        final String userName = _getString(data, 'userName', 'Pemain');
        final String quizTitle = _getString(data, 'quizTitle', 'Kuis');
        final int score = _getInt(data, 'score', 0);
        final int total = _getInt(data, 'total', 1);
        final DateTime? timestamp = _getDateTime(
          data,
          'timestamp',
        ); // ✅ tetap nullable

        return _LeaderboardItem(
          rank: index + 1,
          userName: userName,
          quizTitle: quizTitle,
          score: score,
          total: total,
          timestamp: timestamp,
          theme: theme,
        );
      },
    );
  }

  // Helper parsing (aman)
  String _getString(Map<String, dynamic> data, String key, String fallback) =>
      (data[key] is String && data[key]!.isNotEmpty) ? data[key]! : fallback;

  int _getInt(Map<String, dynamic> data, String key, int fallback) {
    final value = data[key];
    if (value is int) return value;
    if (value is double) return value.toInt();
    return fallback;
  }

  DateTime? _getDateTime(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null; // ✅ eksplisit nullable
  }
}

class _LeaderboardItem extends StatelessWidget {
  final int rank;
  final String userName;
  final String quizTitle;
  final int score;
  final int total;
  final DateTime? timestamp;
  final ThemeData theme;

  const _LeaderboardItem({
    required this.rank,
    required this.userName,
    required this.quizTitle,
    required this.score,
    required this.total,
    this.timestamp,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        leading: _buildRankBadge(),
        title: Text(
          userName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizTitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Skor: ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '$score/$total',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getScoreColor(score, total),
                    ),
                  ),

                  if (timestamp != null)
                    TextSpan(
                      text: ' • ${_formatRelativeTime(timestamp)}', // ✅ aman
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.emoji_events_rounded,
          color: _isTop3(rank)
              ? _getRankColor(rank, theme)
              : theme.colorScheme.primary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildRankBadge() {
    final color = _getRankColor(rank, theme);
    final text = _isTop3(rank) ? '🏆' : '$rank';
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  bool _isTop3(int rank) => rank <= 3;

  Color _getRankColor(int rank, ThemeData theme) {
    switch (rank) {
      case 1:
        return Colors.amber.shade700;
      case 2:
        return Colors.grey.shade600;
      case 3:
        return Colors.brown.shade700;
      default:
        return theme.colorScheme.primary;
    }
  }

  Color _getScoreColor(int score, int total) {
    final ratio = total > 0 ? score / total : 0.0;
    if (ratio >= 0.9) return Colors.green.shade700;
    if (ratio >= 0.7) return Colors.blue.shade700;
    return Colors.orange.shade700;
  }

  // ✅ Perbaikan 2: Ubah parameter jadi DateTime?
  String _formatRelativeTime(DateTime? time) {
    if (time == null) return ''; // ✅ handle null
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} bulan lalu';
    if (diff.inDays > 0) return '${diff.inDays} hari lalu';
    if (diff.inHours > 0) return '${diff.inHours} jam lalu';
    if (diff.inMinutes > 0) return '${diff.inMinutes} menit lalu';
    return 'Baru saja';
  }
}
