import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_buddy/controller/navigation_controller.dart';
import 'package:session_buddy/controller/theme_controller.dart';
import 'package:session_buddy/view/dashboard/dashboard_screen.dart';
import 'package:session_buddy/view/history/history_screen.dart';
import 'package:session_buddy/view/home/home_screen.dart';
import 'package:session_buddy/view/subscription/subscription_screen.dart';
import 'package:session_buddy/view/thc/thc_calculation.dart';
import '../controller/auth_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());
  final AuthController authController = Get.put(AuthController());
  final ThemeController themeController = Get.find();

  final List<Widget> screens = [
    HomeScreen(),
    DashboardScreen(),
    HistoryScreen(),
    SubscriptionScreen(),
    ThcCalculation()
  ];

  final List<String> titles = [
    "",
    "Dashboard",
    "",
    "Subscription",
    "",
  ];

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeData theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            'Logout Confirmation',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                authController.logout();
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Obx(() => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: theme.appBarTheme.backgroundColor,
            automaticallyImplyLeading: false,
            title: Text(
              titles[navigationController.selectedIndex.value],
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: theme.iconTheme.color,
                  size: 22.sp,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor:
                theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: navigationController.selectedIndex.value,
            onTap: (index) {
              navigationController.changeIndex(index);
            },
            backgroundColor: theme.scaffoldBackgroundColor,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_outlined), label: "History"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.diamond_outlined), label: "Subscription"),
            ],
          ),
          body: screens[navigationController.selectedIndex.value],
        ));
  }
}
