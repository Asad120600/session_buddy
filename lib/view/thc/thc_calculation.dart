import 'dart:math'; // ✅ Required for `exp()`

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_buddy/utils/dosage_input_field.dart';
import '../../core/app_colors.dart';
import '../../utils/premium_button.dart';
import '../../utils/text_field.dart';
import '../../utils/dropdown.dart';

class ThcCalculation extends StatefulWidget {
  const ThcCalculation({super.key});

  @override
  _ThcCalculationState createState() => _ThcCalculationState();
}

class _ThcCalculationState extends State<ThcCalculation> {
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String? selectedMethod;
  double estimatedThcLevel = 0.0;

  final List<String> consumptionMethods = ["Smoke", "Vape", "Edible"];

  /// Function to Calculate Estimated THC Blood Level
  void calculateThcLevel() {
    if (dosageController.text.isEmpty ||
        timeController.text.isEmpty ||
        selectedMethod == null) {
      Get.snackbar("Error", "Please fill in all fields",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
      return;
    }

    double dosage = double.tryParse(dosageController.text) ?? 0;
    double timeElapsed = double.tryParse(timeController.text) ?? 0;

    double absorptionRate =
        selectedMethod == "Edible" ? 0.7 : 1.0; // From app logic
    double thcLevel =
        dosage * absorptionRate * exp(-0.03 * timeElapsed); // Exponential decay

    thcLevel = thcLevel.clamp(0.01, 5.0); // Clamp to realistic range

    setState(() {
      estimatedThcLevel = thcLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.diamond, color: AppColors.btnColor),
                  onPressed: () {},
                ),
                const SizedBox(width: 80),
                Text(
                  "Premium",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
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
            CustomTextField(
              hintText: "Time since last session (hours)",
              controller: timeController,
            ),
            const SizedBox(height: 25),
            PremiumButton(
              buttonText: "CALCULATE THC BLOOD LEVEL",
              onPressed: calculateThcLevel,
            ),
            const SizedBox(height: 50),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: AppColors.text),
                  children: [
                    const TextSpan(text: "Estimated THC Level: "),
                    TextSpan(
                      text: "${estimatedThcLevel.toStringAsFixed(2)} mg/L",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.btnColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
