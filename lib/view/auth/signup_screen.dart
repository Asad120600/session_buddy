import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_buddy/controller/auth_controller.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/text_field.dart';
import 'package:session_buddy/view/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up",
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 40.h),
            CustomTextField(hintText: "Email", controller: emailController),
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: "Re-enter password",
              controller: confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            Obx(() {
              return CustomButton(
                text: authController.isLoading.value
                    ? "Processing..."
                    : "SIGN UP",
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        authController.signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          confirmPassword:
                              confirmPasswordController.text.trim(),
                        );
                      },
              );
            }),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: theme.textTheme.bodyMedium),
                TextButton(
                  onPressed: () => Get.to(() => const LoginScreen()),
                  child: Text("Log In",
                      style: TextStyle(color: colorScheme.primary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
