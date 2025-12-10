import 'dart:ui';

import 'package:advanced_task_manager/config/config_imports.dart';

enum TaskPriority {
  low,
  medium,
  high,
}

extension TaskPriorityStringExtension on TaskPriority {
  String get getName {
    switch (this) {
      case TaskPriority.low:
        return AppStrings.low;
      case TaskPriority.medium:
        return AppStrings.medium;
      case TaskPriority.high:
        return AppStrings.high;
    }
  }

  Color get getColor {
    switch (this) {
      case TaskPriority.low:
        return AppColors.blueSoft;
      case TaskPriority.medium:
        return AppColors.orange;
      case TaskPriority.high:
        return AppColors.red;
    }
  }

    Color get getBackgroundColor {
    switch (this) {
      case TaskPriority.low:
        return AppColors.bgBlueSoft;
      case TaskPriority.medium:
        return AppColors.bgOrange;
      case TaskPriority.high:
        return AppColors.bgRed;
    }
  }
}

extension TaskPriorityIntExtension on TaskPriority {
  int get getIntValue {
    switch (this) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
    }
  }
}

extension TaskPriorityExtension on int {
  TaskPriority get getValuePriority {
    switch (this) {
      case 1:
        return TaskPriority.low;
      case 2:
        return TaskPriority.medium;
      case 3:
        return TaskPriority.high;
      default:
        return TaskPriority.low;
    }
  }
}
