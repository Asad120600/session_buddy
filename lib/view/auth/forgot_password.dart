// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:session_buddy/utils/button.dart';
// import 'package:session_buddy/utils/circular_field.dart';
// import 'package:session_buddy/view/auth/reset_confirmation.dart';
// class ForgotPasswordScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   ForgotPasswordScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final ColorScheme colorScheme = theme.colorScheme;
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Forgot Password",
//           style: theme.textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
//           onPressed: () => Get.back(),
//         ),
//         backgroundColor: theme.appBarTheme.backgroundColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//         child: Column(
//           children: [
//             Text(
//               "Enter your email below and we'll send you a link to reset it.",
//               textAlign: TextAlign.left,
//               style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
//             ),
//             const SizedBox(height: 25),
//             CircularTextField(
//                 hintText: "Email Address", controller: emailController),
//             const SizedBox(height: 25),
//             CustomButton(
//               text: "SEND RESET LINK",
//               onPressed: () {
//                 Get.to(ResetPasswordScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:session_buddy/utils/button.dart';
// import 'package:session_buddy/utils/circular_field.dart';
// import 'package:session_buddy/view/auth/reset_confirmation.dart';
// import 'package:uuid/uuid.dart'; // Add this dependency for unique token generation

// class ForgotPasswordScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   ForgotPasswordScreen({super.key});

//   Future<void> _sendPasswordResetLink() async {
//     final String email = emailController.text.trim();
//     if (email.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
//       Get.snackbar(
//         "Error",
//         "Please enter a valid email address",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Get.theme.colorScheme.error,
//       );
//       return;
//     }

//     try {
//       Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

//       // Generate a unique reset token
//       const uuid = Uuid();
//       final resetToken = uuid.v4();
//       final expirationTime = DateTime.now().add(const Duration(hours: 1));

//       // Store the reset token in Firestore
//       await _firestore.collection('password_resets').doc(resetToken).set({
//         'email': email,
//         'expiresAt': Timestamp.fromDate(expirationTime),
//         'used': false,
//       });

//       // Here you would typically send an email with the reset token
//       // For this example, we'll simulate it with a snackbar
//       // In a real app, use a service like Firebase Functions with Nodemailer
//       final resetUrl = 'https://yourapp.com/reset?token=$resetToken';
//       Get.snackbar(
//         "Success",
//         "Reset link sent! Use this token: $resetToken",
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 10),
//         backgroundColor: Get.theme.colorScheme.primary,
//       );
//       debugPrint("Reset URL: $resetUrl"); // For testing

//       Get.back(); // Close loading dialog
//       Get.off(() => const ResetConfirmationScreen());
//     } on FirebaseAuthException catch (e) {
//       Get.back();
//       String errorMessage = "Failed to send reset link";
//       switch (e.code) {
//         case 'user-not-found':
//           errorMessage = "No user found with this email";
//           break;
//         case 'invalid-email':
//           errorMessage = "Invalid email format";
//           break;
//       }
//       Get.snackbar(
//         "Error",
//         errorMessage,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Get.theme.colorScheme.error,
//       );
//     } catch (e) {
//       Get.back();
//       Get.snackbar(
//         "Error",
//         "An unexpected error occurred: $e",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Get.theme.colorScheme.error,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Forgot Password",
//           style: theme.textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
//           onPressed: () => Get.back(),
//         ),
//         backgroundColor: theme.appBarTheme.backgroundColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//         child: Column(
//           children: [
//             Text(
//               "Enter your email below and we'll send you a reset token.",
//               textAlign: TextAlign.left,
//               style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
//             ),
//             const SizedBox(height: 25),
//             CircularTextField(
//               hintText: "Email Address",
//               controller: emailController,
//             ),
//             const SizedBox(height: 25),
//             CustomButton(
//               text: "SEND RESET TOKEN",
//               onPressed: _sendPasswordResetLink,
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
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/circular_field.dart';
import 'package:session_buddy/view/auth/reset_confirmation.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ForgotPasswordScreen({super.key});

  Future<void> _sendPasswordResetLink() async {
    final String email = emailController.text.trim();
    if (email.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      // Send password reset email using Firebase Auth
      await _auth.sendPasswordResetEmail(email: email);

      Get.back(); // Close loading dialog
      Get.snackbar(
        "Success",
        "Password reset link sent! Check your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
      );
      Get.off(() => const ResetConfirmationScreen());
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = "Failed to send reset link";
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email format";
          break;
        case 'too-many-requests':
          errorMessage = "Too many attempts, please try again later";
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
        "An unexpected error occurred: $e",
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
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              "Enter your email below and we'll send you a link to reset your password.",
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 25),
            CircularTextField(
              hintText: "Email Address",
              controller: emailController,
            ),
            const SizedBox(height: 25),
            CustomButton(
              text: "SEND RESET LINK",
              onPressed: _sendPasswordResetLink,
            ),
          ],
        ),
      ),
    );
  }
}