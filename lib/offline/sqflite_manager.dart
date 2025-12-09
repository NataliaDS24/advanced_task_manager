import 'package:advanced_task_manager/offline/tables/tasks_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqFliteManager {
  static final SqFliteManager instance = SqFliteManager._init();

  static Database? _dataBase;
  SqFliteManager._init();

  static const int databaseVersion = 1;
  static const int databaseCurrentVersion = 1;
  static const String databaseName = 'advancedTaskManager.db';

  // Tables
  static final TasksTable tasksTable = TasksTable();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await _initDB(databaseName);
    return _dataBase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreateDB(Database db, int version) async {
    await tasksTable.createTable(db);
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < databaseCurrentVersion) {
      // Put here create tables after 1.0.0 version app
    }
  }

  static Future closeDatabase() async {
    if (_dataBase != null && _dataBase!.isOpen) {
      await _dataBase!.close();
      _dataBase = null;
    }
  }

  static Future clearAllDataTables() async {
    final db = await SqFliteManager.instance.database;
    await db.delete(TasksTable.tasksTable);
  }
}
