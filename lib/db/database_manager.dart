import 'package:pomodoro/db/task_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pomodoro/models/task.dart';


//Class to manage the database. Code based on class explorations
class DatabaseManager {
  static const String DB_NAME = 'pomo.sqlite3.db';
  static const String SQL_CREATE = 'CREATE TABLE IF NOT EXISTS pomo_tasks'
      '(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, '
      'description TEXT NOT NULL, workTime INTEGER NOT NULL, breakTime INTEGER NOT NULL, '
      'goal INTEGER NOT NULL, totalTime INTEGER NOT NULL);';
  static const String SQL_DELETE = 'DELETE FROM pomo_tasks;';
  static const String SQL_INSERT = 'INSERT INTO pomo_tasks'
      '(name, description, workTime, breakTime, goal, totalTime) '
      'VALUES(?, ?, ?, ?, ?, ?);';
  static const String SQL_UPDATE_TIME = 'UPDATE pomo_tasks SET totalTime = ? WHERE id = ?';
  static const String SQL_SELECT = 'SELECT * FROM pomo_tasks ORDER BY name;';
  static DatabaseManager _instance;
  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  //Create SQL statement read from file in main
  static Future initialize() async {
    final db = await openDatabase(DB_NAME,
        version: 1,
        onCreate: (Database db, int version) async {
          createTables(db, SQL_CREATE);
        });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }


  void saveTask({TaskDTO newTask}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT, [newTask.name, newTask.description, newTask.workTime, newTask.breakTime, newTask.goal, newTask.totalTime]);
    });
  }

  void updateTime({Task updateTask}) {
    db.transaction((txn) async {
      await txn.rawUpdate(SQL_UPDATE_TIME, [updateTask.totalTime, updateTask.id]);
    });
  }

  Future<List<Task>> getTasks() async {
    final taskRecords = await db.rawQuery(SQL_SELECT);

    final tasks = taskRecords.map((record){
      return Task(
          id: record['id'],
          name: record['name'],
          description: record['description'],
          workTime: record['workTime'],
          breakTime: record['breakTime'],
          goal: record['goal'],
          totalTime: record['totalTime']);
    }).toList();
    return tasks;
  }
}

