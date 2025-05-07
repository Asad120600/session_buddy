import 'package:flutter/material.dart';
import 'package:session_buddy/core/app_colors.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: AppColors.lightBackground,
    primary: AppColors.primaryColor,
    secondary: AppColors.greyColor,
    surface: AppColors.lightBackground,
    onBackground: AppColors.lightText,
    onPrimary: AppColors.lightText,
    onSecondary: AppColors.lightText,
    onSurface: AppColors.lightText,
  ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightText,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightText),
    titleLarge: TextStyle(color: AppColors.lightText),
    titleMedium: TextStyle(color: AppColors.lightText),
  ),
  cardTheme: CardTheme(
    color: Colors.white, // Explicitly set for light mode
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.btnColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.btnColor,
      foregroundColor: AppColors.lightText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.darkBackground,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: AppColors.darkBackground,
    primary: AppColors.primaryColor,
    secondary: AppColors.greyColor,
    surface: AppColors.darkBackground,
    onBackground: AppColors.darkText,
    onPrimary: AppColors.darkText,
    onSecondary: AppColors.darkText,
    onSurface: AppColors.darkText,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkText,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
    titleLarge: TextStyle(color: AppColors.darkText),
    titleMedium: TextStyle(color: AppColors.darkText),
  ),
  cardTheme: CardTheme(
    color: AppColors.darkBackground, // Explicitly set for dark mode
    elevation: 2,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.btnColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.btnColor,
      foregroundColor: AppColors.darkText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.lightBackground,
  ),
);
