// firebase_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_buddy/core/app_colors.dart';
import 'package:session_buddy/view/auth/login_screen.dart';
import 'package:session_buddy/view/main_screen.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      if (email.trim().isEmpty || password.isEmpty) {
        _showErrorSnackbar('Please enter both email and password.');
        return;
      }

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      _showSuccessSnackbar('Logged in successfully');
      Get.offAll(() => MainScreen());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'We couldn’t find an account with that email.';
          break;
        case 'wrong-password':
          message = 'The password you entered is incorrect.';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Please wait and try again.';
          break;
        case 'invalid-credential':
        case 'invalid-verification-code':
        case 'invalid-verification-id':
          message =
              'The credentials are incorrect or expired. Please try again.';
          break;
        default:
          message =
              'Login failed. Please check your credentials and try again.';
      }
      _showErrorSnackbar(message);
    } catch (e) {
      _showErrorSnackbar('Something went wrong. Please try again later.');
    }
  }

  // Signup function
  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      _showErrorSnackbar('Passwords do not match');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showSuccessSnackbar('Account created successfully');
      await Future.delayed(
          const Duration(seconds: 1)); // Give time to see snackbar
      Get.off(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        default:
          message = 'Signup failed. Please try again.';
      }
      _showErrorSnackbar(message);
      rethrow;
    }
  }

  // Forgot password function
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showSuccessSnackbar('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      String message = e.code == 'user-not-found'
          ? 'No user found with this email.'
          : 'Failed to send reset email. Please try again.';
      _showErrorSnackbar(message);
      rethrow;
    }
  }

  // Helper method for success snackbar
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor
          .withOpacity(0.9), // Using primary color from AppColors
      colorText: Get.isDarkMode
          ? AppColors.darkText
          : AppColors.lightText, // Theme-aware text color
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      borderRadius: 8,
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        'Success',
        style: TextStyle(
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method for error snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(
          0.9), // Keeping red for errors, but could use a custom error color
      colorText: Get.isDarkMode
          ? AppColors.darkText
          : AppColors.lightText, // Theme-aware text color
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      borderRadius: 8,
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        'Error',
        style: TextStyle(
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
