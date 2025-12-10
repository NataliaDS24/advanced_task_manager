import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/enums/task_priority.dart';
import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/models/response_general.dart';
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/offline/tables/tasks_table.dart';
import 'package:advanced_task_manager/ui/screens/home/home_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TaskActionState {
  final TaskModel task;
  final bool isSaving;
  final bool isEditing;
  final String? error;

  TaskActionState({required this.task, this.isSaving = false, this.isEditing = false, this.error});

  TaskActionState copyWith({TaskModel? task, bool? isSaving, bool? isEditing, String? error}) {
    return TaskActionState(
      task: task ?? this.task,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      error: error,
    );
  }
}

class TaskActionNotifier extends StateNotifier<TaskActionState> {
  final Ref ref;

  TaskActionNotifier(this.ref, TaskModel? task)
      : super(TaskActionState(task: task ?? 
        TaskModel.empty(),
        isSaving: false,
      ),
  );

  void updateTitle(String value) {
    state = state.copyWith(task: state.task..title = value);
  }

  void updateDescription(String value) {
    state = state.copyWith(task: state.task..description = value);
  }

  void updateObservation(String value) {
    state = state.copyWith(task: state.task..observation = value);
  }

    void updateStartDate(DateTime date) {
    state = state.copyWith(task: state.task..starDate = date);
  }

  void updateEstimatedEndDate(DateTime date) {
    state = state.copyWith(task: state.task..estimatedEndDate = date);
  }

  void updateState(TaskState newState) {
    state = state.copyWith(task: state.task..state = newState);
  }

  void updatePriority(TaskPriority newPriority) {
    state = state.copyWith(task: state.task..priority = newPriority);
  }

  Future<ResponseGeneral> saveTask() async {
    try {
      state = state.copyWith(isSaving: true);

      if (state.task.id == null) {
        await TasksTable.insertTask(state.task);
      } else {
        await TasksTable.updateTaskById(state.task);
      }

      ref.read(taskNotifierProvider.notifier).loadTasks();
      return ResponseGeneral.success(
        state.task.id == null ? AppStrings.taskCreatedSuccessfully : AppStrings.taskUpdateSuccessfully,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return ResponseGeneral.failed(
        AppStrings.failedActionTask,
      );
    } finally {
      state = state.copyWith(isSaving: false);
      state = state.copyWith(isEditing: false);
    }
  }

    Future<void> enableEditTask({TaskModel? task}) async {
    try {
      state = state.copyWith(isEditing: !state.isEditing, task: task ?? state.task);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

    void resetForm({TaskModel? task}) {
    state = TaskActionState(
      task: task ?? TaskModel.empty(),
      isSaving: false,
      isEditing: false,
      error: null,
    );
  }
}