import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/d_t_picker.dart';
import 'package:session_buddy/utils/dosage_input_field.dart';
import 'package:session_buddy/utils/dropdown.dart';
import 'package:session_buddy/utils/text_field.dart';
import 'package:session_buddy/view/result/buzz_score_result_screen.dart';
import 'package:session_buddy/services/session_service.dart';

class SessionLoggingScreen extends StatefulWidget {
  const SessionLoggingScreen({super.key});

  @override
  _SessionLoggingScreenState createState() => _SessionLoggingScreenState();
}

class _SessionLoggingScreenState extends State<SessionLoggingScreen> {
  final TextEditingController strainController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final List<String> consumptionMethods = ["Smoke", "Vape", "Edible"];
  String? selectedMethod;

  Map<String, dynamic> calculateBuzzData(int dosage, String method) {
    const int maxDosage = 50;
    int weightedDosage = dosage * (method.toLowerCase() == 'edible' ? 2 : 1);

    int buzzScore = weightedDosage.clamp(1, 10);
    double percentage = (weightedDosage / maxDosage).clamp(0.0, 1.0) * 100;

    return {
      'buzzScore': buzzScore,
      'percentage': percentage,
    };
  }

  String getBuzzDescription(int score) {
    if (score <= 3) {
      return "Light buzz, feeling relaxed.";
    } else if (score <= 6) {
      return "Nice buzz, feeling good.";
    } else {
      return "Heavy buzz, time to chill.";
    }
  }

  void handleSubmit() async {
    if (dosageController.text.isEmpty ||
        selectedMethod == null ||
        strainController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.primary,
        colorText: Theme.of(context).colorScheme.onPrimary,
      );
      return;
    }

    int dosage = int.tryParse(dosageController.text) ?? 0;
    String method = selectedMethod!;
    String strain = strainController.text.trim();

    final buzzData = calculateBuzzData(dosage, method);
    int buzzScore = buzzData['buzzScore'];
    double percentage = buzzData['percentage'];
    String buzzDescription = getBuzzDescription(buzzScore);

    try {
      await SessionService().logSession(
        strainName: strain,
        dosage: dosage,
        method: method,
        timestamp: DateTime.now(),
        buzzScore: buzzScore,
      );

      Get.to(() => BuzzScoreResultScreen(
            buzzScore: buzzScore,
            buzzDescription: buzzDescription,
            progressPercentage: percentage,
          ));
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to log session",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Log a new session",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Column(
            children: [
              CustomTextField(
                  hintText: "Enter strain name", controller: strainController),
              const SizedBox(height: 15),
              DosageInputField(
                hintText: "Dosage",
                controller: dosageController,
              ),
              const SizedBox(height: 15),
              CustomDropdown(
                hintText: "Consumption Method",
                items: consumptionMethods,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              DateTimePicker(onDateTimeSelected: (dateTime) {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: CustomButton(
          text: "SUBMIT",
          onPressed: handleSubmit,
        ),
      ),
    );
  }
}
