import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqflite {
  static Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await initialDP();
    }
    return _database!;
  }

  initialDP() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: oncreate,
    );
    print('database created=======================================');
    return database;
  }

  oncreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('''CREATE TABLE notes (
      id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT PRIMARY KRY,
      TITLE TEXT NOT NULL,
      )''');

    print('table created=======================================');
  }

  Future<List<Map>> readData() async {
    Database? db = await database;
    List<Map> response = await db!.rawQuery('SELECT * FROM notes');
    return response;
  }

  Future<void> insertData(String sql) async {
    Database? db = await database;
    int response = await db!.rawInsert(sql);
  }

  Future<void> deletData(String sql) async {
    Database? db = await database;
    int response = await db!.rawDelete(sql);
  }

  Future<void> updateData(String sql) async {
    Database? db = await database;
    int response = await db!.rawUpdate(sql);
  }
}
