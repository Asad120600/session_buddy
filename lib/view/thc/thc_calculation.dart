import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    double absorptionRate = selectedMethod == "Edible" ? 0.7 : 1.0;
    double thcLevel = dosage * absorptionRate * exp(-0.03 * timeElapsed);

    thcLevel = thcLevel.clamp(0.01, 5.0);

    setState(() {
      estimatedThcLevel = thcLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.diamond, color: AppColors.btnColor, size: 24.sp),
                  onPressed: () {},
                ),
                SizedBox(width: 80.w),
                Text(
                  "Premium",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            DosageInputField(
              hintText: "Dosage",
              controller: dosageController,
            ),
            SizedBox(height: 15.h),
            CustomDropdown(
              hintText: "Consumption Method",
              items: consumptionMethods,
              onChanged: (value) {
                setState(() {
                  selectedMethod = value;
                });
              },
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              hintText: "Time since last session (hours)",
              controller: timeController,
            ),
            SizedBox(height: 25.h),
            PremiumButton(
              buttonText: "CALCULATE THC BLOOD LEVEL",
              onPressed: calculateThcLevel,
            ),
            SizedBox(height: 50.h),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16.sp, color: AppColors.text),
                  children: [
                    const TextSpan(text: "Estimated THC Level: "),
                    TextSpan(
                      text: "${estimatedThcLevel.toStringAsFixed(2)} mg/L",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.btnColor,
                        fontSize: 16.sp,
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
