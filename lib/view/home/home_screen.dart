// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:session_buddy/utils/button.dart';
// import 'package:session_buddy/utils/circular_progress.dart';
// import 'package:session_buddy/view/session/session_logging.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final ColorScheme colorScheme = theme.colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           const SizedBox(height: 30),
//           Text(
//             "BUZZ SCORE",
//             style: theme.textTheme.headlineSmall?.copyWith(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 65),
//           CircularProgress(percentage: 50),
//           const SizedBox(height: 70),
//           CustomButton(
//             text: "LOG A NEW SESSION",
//             onPressed: () {
//               Get.to(const SessionLoggingScreen());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  double buzzPercentage = 0;

  @override
  void initState() {
    super.initState();
    loadLatestBuzz();
  }

  Future<void> loadLatestBuzz() async {
    final session = await SessionService().fetchLatestSession();
    if (session == null) return;

    final int dosage = session['dosage'] ?? 0;
    final String method = session['consumption_method']?.toString().toLowerCase() ?? '';

    const int maxDosage = 50;
    int weightedDosage = dosage * (method == 'edible' ? 2 : 1);
    double percentage = (weightedDosage / maxDosage).clamp(0.0, 1.0) * 100;

    setState(() {
      buzzPercentage = percentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            "BUZZ SCORE",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 65),
          CircularProgress(percentage: buzzPercentage),
          const SizedBox(height: 70),
          CustomButton(
            text: "LOG A NEW SESSION",
            onPressed: () {
              Get.to(const SessionLoggingScreen())?.then((_) {
                // Reload after logging new session
                loadLatestBuzz();
              });
            },
          ),
        ],
      ),
    );
  }
}
