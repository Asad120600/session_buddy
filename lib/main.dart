import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_buddy/firebase_options.dart';
import 'package:session_buddy/theme.dart';
import 'package:session_buddy/view/auth/login_screen.dart';
import 'package:session_buddy/controller/theme_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:session_buddy/view/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Session Buddy',
          themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          theme: lightMode,
          darkTheme: darkMode,
          home: _checkLoginStatus(),
        );
      },
    );
  }

  Widget _checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null ?  MainScreen() :  LoginScreen();
  }
}