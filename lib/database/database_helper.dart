import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/common/utils/text_util.dart';
import 'package:task_manager_app/models/task_manager/task_request_model.dart';

class DatabaseHelper {
  //Create instance
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

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
  static const String colCreateDate = 'created_date';
  static const String colUpdateDate = 'updated_date';

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
    debugPrint("Database connected");
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $taskTableName ("
        " $colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $colTitle TEXT NOT NULL, "
        " $colDescription TEXT, "
        " $colStatus INT NOT NULL, "
        " $colDueDate TEXT NOT NULL, "
        " $colCreateDate TEXT NOT NULL, "
        " $colUpdateDate TEXT NOT NULL"
        ")");
    debugPrint("Database create");
  }

  // CRUD METHOD: get, create, update, delete

  // Get all records
  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    // Query the table for all task records. {SELECT * FROM Tasks ORDER BY Id DESC}
    try {
      final result = await db.query(taskTableName, orderBy: '$colId DESC');
      debugPrint(result.toString());
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
        debugPrint(result.toString());
        return result.first;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get task by filter
  Future<List<Map<String, dynamic>>> getByFilter({required Map<String, dynamic> filter}) async {
    final db = await database;
    try {
      String whereClause = '';
      List<dynamic> whereArgs = [];

      // Build query conditions dynamically
      bool hasStatus = filter.containsKey(colStatus) && (filter[colStatus] == 0 || filter[colStatus] == 1);
      bool hasTitle = filter.containsKey(colTitle) && TextUtils.isNotEmpty(filter[colTitle]);

      // Build WHERE clause based on provided filters
      if (hasStatus && hasTitle) {
        whereClause = '$colStatus = ? AND $colTitle LIKE ?';
        whereArgs = [filter[colStatus], '%${filter[colTitle]}%'];
      } else if (hasStatus) {
        whereClause = '$colStatus = ?';
        whereArgs = [filter[colStatus]];
      } else if (hasTitle) {
        whereClause = '$colTitle LIKE ?';
        whereArgs = ['%${filter[colTitle]}%'];
      }

      final result = await db.query(
        taskTableName,
        where: whereClause.isNotEmpty ? whereClause : null,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
        orderBy: '$colId DESC',
      );

      return result; // Return empty list instead of throwing exception
    } catch (e) {
      debugPrint('Error filtering tasks: ${e.toString()}');
      throw Exception('Failed to filter tasks: ${e.toString()}');
    }
  }

  // Create task record
  Future<bool> insert({required TaskRequestModel taskData}) async {
    final db = await database;

    try {
      // Insert the Task into the table.
      // Insert func will return the id of the last inserted row.
      final result = await db.insert(taskTableName, taskData.toJson());

      // 0 could be returned for some specific conflict algorithms if not inserted.
      result != 0 ? debugPrint("create success${taskData.toJson()}") : debugPrint("create fail");

      return result != 0;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // Update task record
  Future<bool> update({required TaskRequestModel taskData, required int id}) async {
    final db = await database;

    try {
      // Update the given Task.
      await db.update(taskTableName, taskData.toJson(),
          where: '$colId = ?',
          // Pass the Task's id as a whereArg to prevent SQL injection.
          whereArgs: [id]);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // Delete a task record
  Future<void> delete({required int id}) async {
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

  Future close() async {
    final db = await database;
    db.close();
  }
}
