import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlServices {
  Database? _database;

  Future<Database?> get database async =>
      (_database != null) ? _database : await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'todo.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXIST Todo (id INTEGER PRIMARY KEY AUTOINCREMENT, taskName TEXT NOT NULL, isDone INTEGER NOT NULL, note TEXT, priority INTEGER NOT NULL)');
      },
    );
    return _database;
  }

  Future<void> insertTask(Map task) async {
    Database? db = await database;

    db!.insert(
        'Todo',
        {
          'taskName': task['taskName'] ?? 'Untitled Task',
          'isDone': task['isDone'], // Convert boolean to integer
          'note': task['note'],
          'priority': task['priority']
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, Object?>>> fetchData() async {
    final db = await database;

    return await db!.query("Todo");
  }

  Future<void> updateTask(int id, Map<String, dynamic> updatedTask) async {
    Database? db = await database;

    await db!.update(
      'Todo',
      updatedTask,
      where: 'id = $id',
    );
  }

  Future<void> deleteTask(int id) async {
    Database? db = await database;

    await db!.delete(
      'Todo',
      where: 'id = $id',
    );
  }
}
