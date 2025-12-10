import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:flutter/material.dart';

 StatelessWidget chipInfoWidget({
  required String label,
  required Color colorBackground,
  required Color colorText,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4,),
    decoration: BoxDecoration(
      color: colorBackground,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: colorText)
    ),
    child: Text(
      label,
      style: AppTextStyles.blackInterSemiBold13.copyWith(
        color: colorText,
      ),
    ),
  );
}