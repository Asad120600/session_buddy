import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/circular_field.dart';
import 'package:session_buddy/view/auth/reset_confirmation.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ForgotPasswordScreen({super.key});

  Future<void> _sendPasswordResetLink() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Enter a valid email", backgroundColor: Get.theme.colorScheme.error);
      return;
    }

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
      Get.snackbar("Success", "Reset link sent!", backgroundColor: Get.theme.colorScheme.primary);
      Get.off(() => const ResetConfirmationScreen());
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(), backgroundColor: Get.theme.colorScheme.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            Text("Enter your email below to receive a reset link.", style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp)),
            SizedBox(height: 25.h),
            CircularTextField(hintText: "Email Address", controller: emailController),
            SizedBox(height: 25.h),
            CustomButton(text: "SEND RESET LINK", onPressed: _sendPasswordResetLink),
          ],
        ),
      ),
    );
  }
}
