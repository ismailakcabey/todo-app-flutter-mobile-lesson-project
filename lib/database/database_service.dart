import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_drive/database/todo_db.dart';
import 'package:test_drive/database/todo_history_db.dart';
import 'package:test_drive/database/user_db.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      print("Veritabanı başlatılıyor...");
      _database = await _initialize();
      return _database!;
    }
  }

  Future<String> get fullPath async {
    const name = 'main.db';
    final path = await getDatabasesPath();
    print("Veritabanı yolu: $path");
    return join(path, name);
  }

  Future<Database> _initialize() async {
    print("Veritabanı initialize ediliyor...");
    final path = await fullPath;
    print("Veritabanı tam yolu: $path");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    print("Veritabanı bağlantısı kuruldu.");
    return database;
  }

  Future<void> create(Database database, int version) async {
    print("Tablolar oluşturuluyor...");
    await TodoDB().createTableTask(database);
    print("Task tablosu oluşturuldu.");
    await UserDB().createTableUser(database);
    print("User tablosu oluşturuldu.");
    await TodoHistoryDB().createTableTaskHistory(database);
    print("Task History tablosu oluşturuldu.");
  }
}
