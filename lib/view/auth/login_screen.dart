import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_buddy/controller/auth_controller.dart';
import 'package:session_buddy/controller/theme_controller.dart';
import 'package:session_buddy/utils/button.dart';
import 'package:session_buddy/utils/text_field.dart';
import 'package:session_buddy/view/auth/forgot_password.dart';
import 'package:session_buddy/view/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              themeController.toggleTheme(!themeController.isDarkMode.value);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 0.1.sh),
            Text(
              "Log In",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60.h),
            CustomTextField(hintText: "Email", controller: emailController),
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child:
                    Text("Forgot Password?", style: theme.textTheme.bodyMedium),
                onPressed: () => Get.to(() => ForgotPasswordScreen()),
              ),
            ),
            Obx(() {
              return CustomButton(
                text:
                    authController.isLoading.value ? "Logging In..." : "LOG IN",
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        authController.login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
              );
            }),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: theme.textTheme.bodyMedium),
                TextButton(
                  onPressed: () => Get.to(() => SignupScreen()),
                  child: Text("SignUp",
                      style: TextStyle(color: colorScheme.primary)),
                ),
              ],
            ),
            SizedBox(height: 0.1.sh),
          ],
        ),
      ),
    );
  }
}
