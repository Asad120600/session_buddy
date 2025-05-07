import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            const SizedBox(height: 40),
            Text(
              "BUZZ SCORE",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 65),
            CircularProgress(percentage: progressPercentage),
            const SizedBox(height: 65),
            Text(
              buzzDescription,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 65, right: 35, left: 35),
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
