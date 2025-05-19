import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/view/main_screen.dart';
import '../../utils/circular_progress.dart';

class BuzzScoreResultScreen extends StatelessWidget {
  final int buzzScore;
  final String buzzDescription;
  final double progressPercentage;

  const BuzzScoreResultScreen({
    super.key,
    required this.buzzScore,
    required this.buzzDescription,
    required this.progressPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text(
              "BUZZ SCORE",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 65.h),
            CircularProgress(
                percentage: buzzScore.toDouble(),
                isScore: true,
                showDescription: true),
            SizedBox(height: 65.h),
            Text(
              buzzDescription,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 65.h, right: 35.w, left: 35.w),
              child: CustomButton(
                text: "Back To Home",
                onPressed: () {
                  Get.to(MainScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
