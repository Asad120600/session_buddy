import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class ResetConfirmationScreen extends StatelessWidget {
  const ResetConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset Link Sent!",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Check your email for a link to reset your password. Follow the instructions there to complete the process.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "BACK TO LOGIN",
              onPressed: () => Get.offAll(() => LoginScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
