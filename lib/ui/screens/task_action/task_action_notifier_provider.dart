import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/ui/screens/task_action/task_action_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

final taskActionNotifierProvider =
    StateNotifierProvider.family<TaskActionNotifier, TaskActionState, TaskModel?>(
  (ref, task) => TaskActionNotifier(ref, task),
);