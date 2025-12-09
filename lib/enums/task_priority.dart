enum TaskPriority {
  low,
  medium,
  high,
}

extension TaskPriorityStringExtension on TaskPriority {
  String get getName {
    switch (this) {
      case TaskPriority.low:
        return 'Baja';
      case TaskPriority.medium:
        return 'Media';
      case TaskPriority.high:
        return 'Alta';
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
