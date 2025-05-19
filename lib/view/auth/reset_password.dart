import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/text_field.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final tokenController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  ResetPasswordScreen({super.key});

  Future<void> _resetPassword() async {
    final token = tokenController.text.trim();
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (token.isEmpty || newPassword != confirmPassword || newPassword.length < 6) {
      Get.snackbar("Error", "Invalid input", backgroundColor: Get.theme.colorScheme.error);
      return;
    }

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      final tokenDoc = await _firestore.collection('password_resets').doc(token).get();
      if (!tokenDoc.exists || tokenDoc['used'] == true) throw Exception("Invalid or used token");

      final expiry = (tokenDoc['expiresAt'] as Timestamp).toDate();
      if (DateTime.now().isAfter(expiry)) throw Exception("Token expired");

      final email = tokenDoc['email'];
      await _auth.signInWithEmailAndPassword(email: email, password: newPassword);
      await _auth.currentUser!.updatePassword(newPassword);
      await _firestore.collection('password_resets').doc(token).update({'used': true});

      Get.back();
      Get.snackbar("Success", "Password updated", backgroundColor: Get.theme.colorScheme.primary);
      Get.offAll(() => const LoginScreen());
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
        title: const Text("Reset Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          children: [
            Text("Enter your reset token and new password", style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
            SizedBox(height: 25.h),
            CustomTextField(hintText: "Reset Token", controller: tokenController),
            SizedBox(height: 25.h),
            CustomTextField(hintText: "New Password", controller: newPasswordController, isPassword: true),
            SizedBox(height: 25.h),
            CustomTextField(hintText: "Confirm Password", controller: confirmPasswordController, isPassword: true),
            SizedBox(height: 25.h),
            CustomButton(text: "CHANGE PASSWORD", onPressed: _resetPassword),
          ],
        ),
      ),
    );
  }
}
