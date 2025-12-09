import 'package:flutter/material.dart';
import 'package:advanced_task_manager/config/config_imports.dart';

class SnackBarUtils {
  static SnackBar baseAlert({
    required String message,
    required TextStyle messageTextStyle,
    required Color backgroundColor,
    required Color borderSideColor,
  }) {
    return SnackBar(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderSideColor),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(8),
          top: Radius.circular(8),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: messageTextStyle,
      ),
    );
  }

  static SnackBar successAlert({
    required String message,
  }) {
    return baseAlert(
      message: message,
      backgroundColor: AppColors.lightGreen,
      borderSideColor: AppColors.darkGreen,
      messageTextStyle: AppTextStyles.blackInterSemiBold15,
    );
  }

  static SnackBar errorAlert({
    required String message,
  }) {
    return baseAlert(
      message: message,
      backgroundColor: AppColors.lightRed,
      borderSideColor: AppColors.red,
      messageTextStyle: AppTextStyles.blackInterSemiBold15,
    );
  }
}
