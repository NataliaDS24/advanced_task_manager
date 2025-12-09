import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/offline/tables/tasks_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeStateNotifier {
  final List<TaskModel> allTasks;
  final List<TaskModel> filteredTasks;
  final bool isLoading;
  final TaskState? filter;

  HomeStateNotifier({
    required this.allTasks,
    required this.filteredTasks,
    this.isLoading = false,
    this.filter,
  });

  HomeStateNotifier copyWith({
    List<TaskModel>? allTasks,
    List<TaskModel>? filteredTasks,
    bool? isLoading,
    TaskState? filter,
  }) {
    return HomeStateNotifier(
      allTasks: allTasks ?? this.allTasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeStateNotifier> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeStateNotifier(allTasks: [], filteredTasks: [])) {
    loadTasks();
  }

  // Load all tasks from SQLite
  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);

    final listTasks = await TasksTable.getAllTasks();

    state = state.copyWith(
      allTasks: listTasks,
      filteredTasks: _applyFilter(listTasks, state.filter),
      isLoading: false,
    );
  }

  // Apply filter to tasks
  List<TaskModel> _applyFilter(List<TaskModel> tasks, TaskState? filter) {
    if (filter == null) return tasks;
    return tasks.where((t) => t.state == filter).toList();
  }

  void changeFilter(TaskState? filter) {
    state = state.copyWith(
      filter: filter,
      filteredTasks: _applyFilter(state.allTasks, filter),
    );
  }

  // Change status from completed to pending
  Future<void> toggleTaskCompleted(TaskModel task) async {
    if (task.state != TaskState.completed) {
      await TasksTable.updateStateTaskComplete(task);
    }
    loadTasks();
  }
}