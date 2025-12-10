import 'package:flutter/material.dart';
import 'package:advanced_task_manager/config/config_imports.dart';

class ThemeDataApp {
  static ThemeData themeData = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    scaffoldBackgroundColor: AppColors.grey,
    useMaterial3: true,
  );
}
