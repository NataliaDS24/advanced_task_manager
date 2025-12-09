import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/data/api_helper/api_const.dart';
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:dio/dio.dart';

class TaskRepository {
  final Dio dio;
  TaskRepository(this.dio);

  Future<List<TaskModel>> fetchInitialTasks({int limit = 15}) async {
    try {
      final response = await dio.get(ApiConst.all);

      if (response.statusCode == 200) {
        final List data = response.data;

        return data.take(limit).map((e) => TaskModel.fromMap(map: e)).toList();
      } else {
        throw Exception(AppStrings.errorLoadingTaskData);
      }
    } catch (e) {
      throw Exception("${AppStrings.errorTaskRepository} $e");
    }
  }
}