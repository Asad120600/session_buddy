import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class ResetConfirmationScreen extends StatelessWidget {
  const ResetConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reset Link Sent!", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 28.sp)),
            SizedBox(height: 20.h),
            Text(
              "Check your email and follow the instructions to reset your password.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 40.h),
            CustomButton(text: "BACK TO LOGIN", onPressed: () => Get.offAll(() => const LoginScreen())),
          ],
        ),
      ),
    );
  }
}
