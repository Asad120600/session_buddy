import 'package:flutter/material.dart';
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
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "Log In",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            CustomTextField(
              hintText: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: theme.inputDecorationTheme.border?.borderSide ??
                      BorderSide(color: colorScheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      theme.inputDecorationTheme.enabledBorder?.borderSide ??
                          BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 220),
              child: TextButton(
                child: Text(
                  "Forgot Password?",
                  style: theme.textTheme.bodyMedium,
                ),
                onPressed: () {
                  Get.to(() => ForgotPasswordScreen());
                },
              ),
            ),
            const SizedBox(height: 5),
            Obx(() {
              return CustomButton(
                text:
                    authController.isLoading.value ? "Logging In..." : "LOG IN",
                onPressed: authController.isLoading.value
                    ? () {}
                    : () {
                        authController.login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
              );
            }),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignupScreen());
                    },
                    child: Text(
                      "SignUp",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
