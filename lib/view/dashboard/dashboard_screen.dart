import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../utils/circular_progress.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double progressPercentage = 0;
  List<Map<String, dynamic>> recentSessions = [];

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final query = await FirebaseFirestore.instance
        .collection('sessions')
        .where('user_id', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(3)
        .get();

    if (query.docs.isNotEmpty) {
      final sessions = query.docs.map((doc) => doc.data()).toList();

      final latestSession = sessions.first;
      final int dosage = latestSession['dosage'] ?? 0;
      final String method =
          latestSession['consumption_method']?.toString().toLowerCase() ?? '';

      const int maxDosage = 50;
      int weightedDosage = dosage * (method == 'edible' ? 2 : 1);
      double percentage = (weightedDosage / maxDosage).clamp(0.0, 1.0) * 100;

      setState(() {
        recentSessions = sessions;
        progressPercentage = percentage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  CircularProgress(
                    percentage: progressPercentage,
                    showDescription: true,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Recent Sessions",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: recentSessions.isEmpty
                  ? const Center(child: Text("No sessions found"))
                  : ListView.builder(
                      itemCount: recentSessions.length,
                      itemBuilder: (context, index) {
                        final session = recentSessions[index];
                        final timestamp =
                            (session['timestamp'] as Timestamp).toDate();
                        final int dosage = session['dosage'] ?? 0;
                        final String method = session['consumption_method']
                                ?.toString()
                                .toLowerCase() ??
                            '';

                        const int maxDosage = 50;
                        int weightedDosage =
                            dosage * (method == 'edible' ? 2 : 1);
                        double percentage =
                            (weightedDosage / maxDosage).clamp(0.0, 1.0) * 100;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  theme.cardTheme.color ?? colorScheme.surface,
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
                                const SizedBox(height: 5),
                                Text(
                                  "Dosage: ${dosage} mg",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    color: colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Buzz Score: ${percentage.toStringAsFixed(1)}%",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 5),
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
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
