import 'package:advanced_task_manager/core/init_providers.dart';
import 'package:advanced_task_manager/data/repositories/tasks/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dio = ref.read(dioProvider);
  return TaskRepository(dio);
});