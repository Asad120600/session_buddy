import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchSessionHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final query = await FirebaseFirestore.instance
        .collection('sessions')
        .where('user_id', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .get();

    return query.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "History",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchSessionHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final sessions = snapshot.data ?? [];

            if (sessions.isEmpty) {
              return const Center(child: Text("No session history found."));
            }

            return ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final DateTime timestamp =
                    (session['timestamp'] as Timestamp).toDate();
                final int dosage = session['dosage'] ?? 0;
                final String method =
                    session['consumption_method']?.toString().toLowerCase() ??
                        '';

                const int maxDosage = 50;
                int weightedDosage = dosage * (method == 'edible' ? 2 : 1);
                double percentage =
                    (weightedDosage / maxDosage).clamp(0.0, 1.0) * 100;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color ?? colorScheme.surface,
                      border: Border.all(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session['strain_name'] ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Dosage: ${dosage} mg",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Buzz Score: ${percentage.toStringAsFixed(1)}%",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${DateFormat('hh:mm a').format(timestamp)} • ${DateFormat('dd/MM/yyyy').format(timestamp)}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
