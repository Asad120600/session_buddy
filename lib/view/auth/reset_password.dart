
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:session_buddy/utils/button.dart';
// import 'package:session_buddy/utils/text_field.dart';
// import 'package:session_buddy/view/auth/login_screen.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   ResetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text(""),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: theme.appBarTheme.backgroundColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
//         child: Column(
//           children: [
//             Text(
//               "Enter new password and confirm",
//               textAlign: TextAlign.center,
//               style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
//             ),
//             const SizedBox(height: 25),
//             CustomTextField(
//                 isPassword: true,
//                 hintText: "New Password",
//                 controller: newPasswordController),
//             const SizedBox(height: 25),
//             CustomTextField(
//                 isPassword: true,
//                 hintText: "Confirm Password",
//                 controller: confirmPasswordController),
//             const SizedBox(height: 25),
//             CustomButton(
//               text: "CHANGE PASSWORD",
//               onPressed: () {
//                 Get.to(LoginScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/text_field.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ResetPasswordScreen({super.key});

  Future<void> _resetPassword() async {
    final token = tokenController.text.trim();
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (token.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter the reset token",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      // Verify the reset token
      final tokenDoc = await _firestore.collection('password_resets').doc(token).get();
      if (!tokenDoc.exists) {
        throw Exception("Invalid reset token");
      }

      final tokenData = tokenDoc.data()!;
      if (tokenData['used'] == true) {
        throw Exception("Token already used");
      }

      final expiresAt = (tokenData['expiresAt'] as Timestamp).toDate();
      if (DateTime.now().isAfter(expiresAt)) {
        throw Exception("Reset token has expired");
      }

      final email = tokenData['email'] as String;

      // Reset the password
      await _auth.signInWithEmailAndPassword(email: email, password: newPasswordController.text);
      await _auth.currentUser!.updatePassword(newPassword);

      // Mark token as used
      await _firestore.collection('password_resets').doc(token).update({'used': true});

      Get.back(); // Close loading dialog
      Get.snackbar(
        "Success",
        "Password reset successful!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
      );
      Get.offAll(() =>  LoginScreen());
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = "Failed to reset password";
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found";
          break;
        case 'wrong-password':
          errorMessage = "Current password is incorrect";
          break;
      }
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: Column(
          children: [
            Text(
              "Enter your reset token and new password",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 25),
            CustomTextField(
              hintText: "Reset Token",
              controller: tokenController,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              isPassword: true,
              hintText: "New Password",
              controller: newPasswordController,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              isPassword: true,
              hintText: "Confirm Password",
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 25),
            CustomButton(
              text: "CHANGE PASSWORD",
              onPressed: _resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}

