import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_drive/database/database_service.dart';
import 'package:test_drive/models/task_history_model.dart';
import 'package:test_drive/models/task_model.dart';

class TodoHistoryDB {
  final tableName = "todo_historys";
  final tableNameTodos = "todos";
  final userTableName = "users";

  Future<void> createTableTaskHistory(Database database) async {
    print("task history tablosu create edildi");
    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableName (
  "id" INTEGER NOT NULL,
  "description" TEXT NOT NULL,
  "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as INTEGER)),
  "createdUserId" INTEGER,
  "taskId" INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT),
  FOREIGN KEY ("createdUserId") REFERENCES users("id"),
  FOREIGN KEY ("taskId") REFERENCES todos("id")
    );
""");
    print("bitti task history tablosu");
  }

  Future<int> create({
    required String description,
    required int createdUserId,
    required int taskId,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (description, createdUserId, taskId, createdAt) VALUES (?,?,?,?)''',
        [
          description,
          createdUserId,
          taskId,
          DateTime.now().microsecondsSinceEpoch
        ]);
  }

  Future<List<TaskHistory>> fetchAll(int taskId) async {
    final database = await DatabaseService().database;
    final todo_historys = await database
        .rawQuery("""SELECT * FROM $tableName WHERE taskId = ? """, [taskId]);
    return todo_historys
        .map((history) => TaskHistory.fromMap(history))
        .toList();
  }
}
