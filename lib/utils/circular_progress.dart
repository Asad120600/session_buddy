// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import '../core/app_colors.dart';

// class CircularProgress extends StatefulWidget {
//   final double percentage;
//   final bool showDescription; // Toggle for description

//   const CircularProgress({
//     super.key,
//     required this.percentage,
//     this.showDescription = false, // Default to true
//   });

//   @override
//   State<CircularProgress> createState() => _CircularProgressState();
// }

// class _CircularProgressState extends State<CircularProgress> {
//   String buzzDescription = "Moderate";

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 20,
//             spreadRadius: 5,
//             offset: Offset(0, 5),
//           ),
//           BoxShadow(
//             color: Colors.white,
//             blurRadius: 10,
//             spreadRadius: -5,
//           ),
//         ],
//       ),
//       child: CircularPercentIndicator(
//         radius: 120.0,
//         lineWidth: 28.0,
//         percent: widget.percentage / 100,
//         center: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center, // Ensures proper centering
//           children: [
//             Text(
//               "${widget.percentage.toInt()}%",
//               style: TextStyle(
//                 fontSize: 55,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             if (widget.showDescription) // Show description if enabled
//               Text(
//                 buzzDescription,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.btnColor,
//                 ),
//               ),
//           ],
//         ),
//         progressColor: AppColors.btnColor,
//         backgroundColor: AppColors.lightGrey,
//         circularStrokeCap: CircularStrokeCap.round,
//         startAngle: 180, // Starts progress from the left
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgress extends StatefulWidget {
  final double percentage;
  final bool showDescription; // Toggle for description

  const CircularProgress({
    super.key,
    required this.percentage,
    this.showDescription = false, // Default to false
  });

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  String buzzDescription = "Moderate";

  @override
  Widget build(BuildContext context) {
    // Get theme data from context
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: colorScheme
                .surface, // Using surface color for white-like shadow
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
      ),
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 28.0,
        percent: widget.percentage / 100,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.percentage.toInt()}%",
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.showDescription)
              Text(
                buzzDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
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
