import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_drive/database/database_service.dart';
import 'package:test_drive/models/task_model.dart';

class TodoDB {
  final tableName = "todos";
  final userTableName = "users";

  Future<void> createTableTask(Database database) async {
    print("task tablosu create edildi");
    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableName (
  "id" INTEGER NOT NULL,
  "title" TEXT NOT NULL,
  "taskStatus" TEXT NOT NULL,
  "summary" TEXT,
  "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as INTEGER)),
  "updatedAt" INTEGER,
  "createdUserId" INTEGER,
  "assignedUserId" INTEGER,
  "updatedUserId" INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT),
  FOREIGN KEY ("assignedUserId") REFERENCES users("id"),
  FOREIGN KEY ("createdUserId") REFERENCES users("id"),
  FOREIGN KEY ("updatedUserId") REFERENCES users("id")
    );
""");
    print("bitti todos tablosu");
  }

  Future<int> create(
      {required String title,
      required String taskStatus,
      required String summary,
      required int createdUserId,
      required int assignedUserId}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (title, taskStatus, summary, createdUserId, assignedUserId, createdAt) VALUES (?,?,?,?,?,?)''',
        [
          title,
          taskStatus,
          summary,
          createdUserId,
          assignedUserId,
          DateTime.now().microsecondsSinceEpoch
        ]);
  }

  Future<List<Task>> fetchAll(String? title) async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
        """SELECT * FROM $tableName WHERE title LIKE '%$title%' ORDER BY COALESCE(updatedAt, createdAt)""");
    return todos.map((todo) => Task.fromMap(todo)).toList();
  }

  Future<Task> fetchById(int id) async {
    final database = await DatabaseService().database;
    final todo = await database
        .rawQuery("""SELECT * FROM $tableName WHERE id = ? """, [id]);
    final todos = Task.fromMap(todo.first);
    return todos;
  }

  Future<int> update({
    required int id,
    String? title,
    String? summary,
    String? taskStatus,
    int? assignedUserId,
    int? updatedUserId,
  }) async {
    final database = await DatabaseService().database;
    return await database.update(
        tableName,
        {
          if (title != null) 'title': title,
          if (summary != null) 'summary': summary,
          if (taskStatus != null) 'taskStatus': taskStatus,
          if (assignedUserId != null) 'assignedUserId': assignedUserId,
          if (updatedUserId != null) 'updatedUserId': updatedUserId,
          'updatedAt': DateTime.now().microsecondsSinceEpoch
        },
        where: "id = ?",
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }

  Future<void> deleteById(int id) async {
    final database = await DatabaseService().database;
    final todo = await database
        .rawDelete("""SELECT * FROM $tableName WHERE id = ? """, [id]);
  }
}
