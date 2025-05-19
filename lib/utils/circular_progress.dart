import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgress extends StatelessWidget {
  final double percentage;
  final bool showDescription;
  final bool isScore;

  const CircularProgress({
    super.key,
    required this.percentage,
    this.showDescription = false,
    this.isScore = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Optional description for buzz score
    String buzzDescription = '';
    if (isScore && showDescription) {
      final int score = percentage.toInt();
      if (score <= 3) {
        buzzDescription = "Light buzz";
      } else if (score <= 6) {
        buzzDescription = "Nice buzz";
      } else {
        buzzDescription = "Heavy buzz";
      }
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.3),
            blurRadius: 20.r,
            spreadRadius: 5.r,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: colorScheme.surface,
            blurRadius: 10.r,
            spreadRadius: -5.r,
          ),
        ],
      ),
      child: CircularPercentIndicator(
        radius: 120.r,
        lineWidth: 28.r,
        percent:
            isScore ? (percentage / 10).clamp(0.0, 1.0) : (percentage / 100),
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isScore ? percentage.toInt().toString() : "${percentage.toInt()}",
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 55.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showDescription)
              Text(
                isScore ? buzzDescription : "Current buzz",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
          ],
        ),
        progressColor: colorScheme.primary,
        backgroundColor: colorScheme.surfaceVariant,
        circularStrokeCap: CircularStrokeCap.round,
        startAngle: 180,
      ),
    );
  }
}
