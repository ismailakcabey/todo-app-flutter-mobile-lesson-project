import 'package:sqflite/sqflite.dart';
import 'package:test_drive/database/database_service.dart';
import 'package:test_drive/models/user_model.dart';

class UserDB {
  final tableName = "users";

  Future<void> createTableUser(Database database) async {
    await database.execute(""" CREATE TABLE IF NOT EXISTS $tableName (
  "id" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL,
  "password" TEXT NOT NULL,
  "company" TEXT NOT NULL,
  "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as INTEGER)),
  "updatedAt" INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT)
    );
""");
  }

  Future<int> create(
      {required String name,
      required String email,
      required String password,
      required String company}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (name, email, password, company, createdAt) VALUES (?,?,?,?,?)''',
        [
          name,
          email,
          password,
          company,
          DateTime.now().microsecondsSinceEpoch
        ]);
  }

  Future<List<User>> fetchAll() async {
    final database = await DatabaseService().database;
    final users = await database.rawQuery(
        """SELECT * FROM $tableName ORDER BY COALESCE(updatedAt, createdAt)""");
    return users.map((user) => User.fromMap(user)).toList();
  }

  Future<User?> fetchByEmail(String email) async {
    final database = await DatabaseService().database;
    final user = await database
        .rawQuery("""SELECT * FROM $tableName WHERE email = ? """, [email]);
    if (user.isEmpty) {
      return null;
    } else {
      return User.fromMap(user.first);
    }
  }

  Future<User> fetchById(int id) async {
    final database = await DatabaseService().database;
    final user = await database
        .rawQuery("""SELECT * FROM $tableName WHERE id = ? """, [id]);
    return User.fromMap(user.first);
  }

  Future<int> update(
      {required int id, String? name, String? email, String? company}) async {
    final database = await DatabaseService().database;
    return await database.update(
        tableName,
        {
          if (name != null) 'name': name,
          if (email != null) 'email': email,
          if (company != null) 'company': company,
          'updatedAt': DateTime.now().microsecondsSinceEpoch
        },
        where: "id = ?",
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }

  Future<void> deleteById(int id) async {
    final database = await DatabaseService().database;
    final user = await database
        .rawDelete("""SELECT * FROM $tableName WHERE id = ? """, [id]);
  }
}
