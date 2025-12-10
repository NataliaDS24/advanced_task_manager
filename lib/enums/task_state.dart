import 'dart:ui';
import 'package:advanced_task_manager/config/config_imports.dart';

enum TaskState {
  pending,
  inProgress,
  completed,
}

extension TaskStateStringExtension on TaskState {
  String get getName {
    switch (this) {
      case TaskState.pending:
        return AppStrings.pending;
      case TaskState.inProgress:
        return AppStrings.inProgres;
      case TaskState.completed:
        return AppStrings.completed;
    }
  }

  Color get getColor {
    switch (this) {
      case TaskState.pending:
        return AppColors.greyMedium;
      case TaskState.inProgress:
        return AppColors.cynBlue;
      case TaskState.completed:
        return AppColors.darkGreen;
    }
  }
}

extension TaskStateIntExtension on TaskState {
  int get getIntValue {
    switch (this) {
      case TaskState.pending:
        return 1;
      case TaskState.inProgress:
        return 2;
      case TaskState.completed:
        return 3;
    }
  }
}

extension TaskStateExtension on int {
  TaskState get getValueState {
    switch (this) {
      case 1:
        return TaskState.pending;
      case 2:
        return TaskState.inProgress;
      case 3:
        return TaskState.completed;
      default:
        return TaskState.pending;
    }
  }
}
