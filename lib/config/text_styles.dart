import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // White color
  static const TextStyle whiteInterBold20 = TextStyle(
    color: AppColors.white,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle whiteInterSemiBold16 = TextStyle(
    color: AppColors.white,
    fontFamily: 'Inter-SemiBold',
    fontSize: 16,
  );

  // Primary color
  static const TextStyle primaryInterSemiBold20 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'Inter-SemiBold',
    fontSize: 20,
  );

  static const TextStyle primaryInterBold40 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 40,
  );

  // Black color
  static const TextStyle blackInterBold18 = TextStyle(
    color: AppColors.black,
    fontFamily: 'Inter-Bold',
    fontSize: 18,
  );

  static const TextStyle blackInterSemiBold15 = TextStyle(
    color: AppColors.black,
    fontFamily: 'Inter-SemiBold',
    fontSize: 15,
  );

    static const TextStyle blackInterThin10 = TextStyle(
    color: AppColors.black,
    fontFamily: 'Inter-Thin',
    fontSize: 10,
  );
}
