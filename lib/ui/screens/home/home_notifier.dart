import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/offline/tables/tasks_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeStateNotifier {
  final List<TaskModel> tasks;
  final bool isLoading;

  HomeStateNotifier({
    required this.tasks,
    this.isLoading = false,
  });

  HomeStateNotifier copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
  }) {
    return HomeStateNotifier(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeStateNotifier> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeStateNotifier(tasks: [])) {
    loadTasks();
  }

  // Load all tasks from SQLite
  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);

    final listTasks = await TasksTable.getAllTasks();

    state = state.copyWith(tasks: listTasks, isLoading: false);
  }

  // Change status from completed to pending
  Future<void> toggleTaskCompleted(TaskModel task) async {
    if (task.state != TaskState.completed) {
      await TasksTable.updateStateTaskComplete(task);
    }
    loadTasks();
  }
}