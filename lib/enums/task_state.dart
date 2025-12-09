enum TaskState {
  pending,
  inProgress,
  completed,
}

extension TaskStateStringExtension on TaskState {
  String get getName {
    switch (this) {
      case TaskState.pending:
        return 'Pendiente';
      case TaskState.inProgress:
        return 'En Progreso';
      case TaskState.completed:
        return 'Completada';
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
