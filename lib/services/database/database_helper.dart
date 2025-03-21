import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/models/task_manager/task_model.dart';

class DatabaseHelper {
  //Create instance
  static final DatabaseHelper instance = DatabaseHelper._instance();

  DatabaseHelper._instance();

  static Database? _database;

  // Define name and version
  static const String databaseName = "database.db";
  static const int versionNumber = 1;
  static const String taskTableName = 'Tasks';

  // Define col name
  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colStatus = 'status';
  static const String colDueDate = 'due_date';
  static const String colCreateDate = 'create_date';
  static const String colUpdateDate = 'update_date';

  // Define a getter to access the database.
  Future<Database> get database async {
    // If the database instance is already initialized, return it
    if (_database != null) {
      return _database!;
    }

    // If the database instance is not initialized, call the init method
    _database = await initDb();

    return _database!;
  }

  initDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    // Open database
    // If the database is first created, create a table
    var db = await openDatabase(
      path,
      version: versionNumber,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $taskTableName ("
        " $colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $colTitle TEXT NOT NULL, "
        " $colDescription TEXT, "
        " $colStatus INT NOT NULL, "
        " $colDueDate TEXT, "
        " $colCreateDate TEXT NOT NULL, "
        " $colUpdateDate TEXT NOT NULL"
        ")");
  }

  // CRUD METHOD: get, create, update, delete

  // Get all records
  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    // Query the table for all task records. {SELECT * FROM Tasks ORDER BY Id ASC}
    try {
      final result = await db.query(taskTableName, orderBy: '$colId ASC');
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get task by id
  Future<Map<String, dynamic>> getById({required int id}) async {
    final db = await database;
    // Query the table for the task record what has colId = id.
    try {
      final result = await db.query(
        taskTableName,
        where: '$colId = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) {
        throw Exception("Task not found!");
      } else {
        return result.first;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Create task record
  Future<bool> insert(TaskModel task) async {
    final db = await database;

    try {
      // Insert the Task into the table.
      // Insert func will return the id of the last inserted row.
      final result = await db.insert(taskTableName, task.toJson());

      // 0 could be returned for some specific conflict algorithms if not inserted.
      return result != 0;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Update task record
  Future<int> update(TaskModel task) async {
    final db = await database;

    try {
      // Update the given Task.
      var res = await db.update(taskTableName, task.toJson(),
          where: '$colId = ?',
          // Pass the Task's id as a whereArg to prevent SQL injection.
          whereArgs: [task.id]);
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Delete a task record
  Future<void> delete(int id) async {
    final db = await database;

    try {
      // Remove the Note from the database.
      await db.delete(taskTableName,
          // Use a `where` clause to delete a specific Task.
          where: "$colId = ?",
          // Pass the Task's id as a whereArg to prevent SQL injection.
          whereArgs: [id]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
