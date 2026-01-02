import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Quiz')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('scores')
            .where('uid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (_, snap) {
          if (snap.hasError) return Center(child: Text('${snap.error}'));
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada riwayat'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text(d['quizTitle']),
                  subtitle: Text('${d['score']}/${d['total']}'),
                  trailing: Text(
                    d['timestamp']?.toDate().toString().substring(0, 16) ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
