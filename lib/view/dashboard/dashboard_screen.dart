import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/circular_progress.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int buzzScore = 0;
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
        .get(); // removed .limit(3)

    if (query.docs.isNotEmpty) {
      final sessions = query.docs.map((doc) => doc.data()).toList();

      final latestSession = sessions.first;
      final int dosage = latestSession['dosage'] ?? 0;
      final String method = latestSession['consumption_method']?.toString().toLowerCase() ?? '';

      const int maxDosage = 50;
      int weightedDosage = dosage * (method == 'edible' ? 2 : 1);
      int score = ((weightedDosage / maxDosage) * 10).round().clamp(1, 10);

      setState(() {
        recentSessions = sessions;
        buzzScore = score;
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Column(
                children: [
                  CircularProgress(
                    percentage: buzzScore.toDouble(),
                    showDescription: true,
                    isScore: true,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Recent Sessions",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
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
                        final int buzzScoreLocal = session['buzz_score'] ?? 0;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: theme.cardTheme.color ?? colorScheme.surface,
                              border: Border.all(color: colorScheme.primary),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session['strain_name'] ?? '',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  session['consumption_method'] ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Dosage: $dosage mg",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    color: colorScheme.secondary,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Buzz Score: $buzzScoreLocal / 10",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16.sp, color: colorScheme.primary),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "${DateFormat('hh:mm a').format(timestamp)} • ${DateFormat('dd/MM/yyyy').format(timestamp)}",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 14.sp,
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
