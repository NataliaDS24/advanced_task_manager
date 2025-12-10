import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:flutter/material.dart';

 Center noDataWidget({
  required String text,
}) {
  return  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.noData),
          Text(
            text,
            style: AppTextStyles.primaryInterSemiBold20,
          ),
        ],
      ),
    );
}