import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/offline/sqflite_manager.dart';
import 'package:sqflite/sqflite.dart';

class TasksTable {
  static const String tasksTable = 'tasks';

  /*
   * @param {INTEGER} state is bool instead of integer
   * @param {INTEGER} priority is bool instead of integer
   */
  Future<void> createTable(Database db) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $tasksTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        starDate TEXT,
        estimatedEndDate TEXT,
        state INTEGER,
        priority INTEGER,
        observation TEXT
      )
      ''',
    );
  }

  static Future<void> insertAllTask(
    List<TaskModel> tasks,
  ) async {
    final db = await SqFliteManager.instance.database;

    for (final task in tasks) {
      await db.insert(
        tasksTable,
        task.toMapOffline(),
      );
    }

    await SqFliteManager.closeDatabase();
  }

  static Future<void> insertTask(
    TaskModel task,
  ) async {
    final db = await SqFliteManager.instance.database;

    await db.insert(
      tasksTable,
      task.toMapOffline(),
    );

    await SqFliteManager.closeDatabase();
  }

  static Future<List<TaskModel>> getAllTasks() async {
        final db = await SqFliteManager.instance.database;
    final result = await db.query(tasksTable);

    await SqFliteManager.closeDatabase();

    return result.map((json) => TaskModel.fromMapOffline(map: json)).toList();
  }

    static Future<void> updateTaskById(
      TaskModel task,
    ) async {
      final db = await SqFliteManager.instance.database;

      await db.update(
        tasksTable,
        task.toMapUpdate(),
        where: 'id = ?',
        whereArgs: [task.id],
      );

      await SqFliteManager.closeDatabase();
    }

    static Future<void> updateStateTaskComplete(
      TaskModel task,
    ) async {
      final db = await SqFliteManager.instance.database;

      await db.update(
        tasksTable,
        {'state': 3},
        where: 'id = ?',
        whereArgs: [task.id],
      );

      await SqFliteManager.closeDatabase();
    }

}
