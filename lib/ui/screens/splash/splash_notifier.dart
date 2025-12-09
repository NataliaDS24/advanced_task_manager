import 'package:advanced_task_manager/core/init_providers.dart';
import 'package:advanced_task_manager/data/repositories/tasks/task_repository_provider.dart';
import 'package:advanced_task_manager/offline/tables/tasks_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sqflite/sqflite.dart';

class SplashState {
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final bool isReady;

  SplashState({
    required this.isLoading,
    required this.isReady,
    this.isError = false,
    this.errorMessage,
  });

  factory SplashState.loading() => SplashState(isLoading: true, isReady: false);

  factory SplashState.ready() => SplashState(isLoading: false, isReady: true);

  factory SplashState.error(String msg) =>
      SplashState(isLoading: false, isReady: false, isError: true, errorMessage: msg);
}

class SplashNotifier extends StateNotifier<SplashState> {
  final Ref ref;

  SplashNotifier(this.ref) : super(SplashState.loading());

  Future<void> initializeApp() async {
    try {
      state = SplashState.loading();

      // Obtain the database instance
      final Database db = await ref.read(databaseProvider.future);

      // Check if there are saved tasks to load the first ones through the API
      final List<Map<String, dynamic>> tasks = await db.query(TasksTable.tasksTable);

      if (tasks.isEmpty) {
        await _loadInitialTasksFromApi(db);
      }

      // Initialization completed
      state = SplashState.ready();
    } catch (e) {
      state = SplashState.error(e.toString());
    }
  }

  Future<void> _loadInitialTasksFromApi(Database db) async {
    final repo = ref.read(taskRepositoryProvider);

    final tasks = await repo.fetchInitialTasks();

    await TasksTable.insertAllTask(tasks);
  }
}