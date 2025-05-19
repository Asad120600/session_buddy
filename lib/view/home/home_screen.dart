import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/circular_progress.dart';
import 'package:session_buddy/view/session/session_logging.dart';
import 'package:session_buddy/services/session_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int buzzScore = 0;

  @override
  void initState() {
    super.initState();
    loadLatestBuzz();
  }

  Future<void> loadLatestBuzz() async {
    final session = await SessionService().fetchLatestSession();
    if (session == null) return;

    final int dosage = session['dosage'] ?? 0;
    final String method =
        session['consumption_method']?.toString().toLowerCase() ?? '';

    const int maxDosage = 50;
    int weightedDosage = dosage * (method == 'edible' ? 2 : 1);
    int score = ((weightedDosage / maxDosage) * 10).round().clamp(1, 10);

    setState(() {
      buzzScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Text(
            "BUZZ SCORE",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 65.h),
          CircularProgress(percentage: buzzScore.toDouble(), isScore: true),
          SizedBox(height: 70.h),
          CustomButton(
            text: "LOG A NEW SESSION",
            onPressed: () {
              Get.to(const SessionLoggingScreen())?.then((_) {
                loadLatestBuzz();
              });
            },
          ),
        ],
      ),
    );
  }
}
