import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, isComplete INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodoItem(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isComplete: maps[i]['isComplete'] == 1,
      );
    });
  }

  Future<void> updateTodoItem(Todo todo) async {
    final db = await database;
    await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodoItem(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}