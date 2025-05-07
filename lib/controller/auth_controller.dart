// auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:session_buddy/services/firebase_service.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  RxBool isLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      await _firebaseService.login(email: email, password: password);
    } catch (e) {
      // Error is already handled in FirebaseService with snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    isLoading.value = true;
    try {
      await _firebaseService.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      // Error is already handled in FirebaseService with snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } finally {
      isLoading.value = false;
    }
  }
}
