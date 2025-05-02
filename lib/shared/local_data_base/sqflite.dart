import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp2/constant.dart';

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
      version: 3,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
    print('database created=======================================');
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
       $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL

      )
    ''');
    print('Table $tableName created');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('upgrade database');
    await db.execute(
      'ALTER TABLE notes ADD COLUMN $columnTime TEXT NOT NULL DEFAULT ""',
    );
    // إضافة عمود time إذا لم يكن موجودًا
    await db.execute(
      'ALTER TABLE notes ADD COLUMN $columnDate TEXT NOT NULL DEFAULT ""',
    );
    print('Table $tableName upgraded');
  }

  Future<List<Map>> readData() async {
    Database? db = await database;
    List<Map> response = await db!.rawQuery('SELECT * FROM $tableName');
    return response;
  }

  Future<int> insertData({
    required String title,
    required String date,
    required String time,
  }) async {
    Database? db = await database;
    int response = await db!.rawInsert(
      "insert into $tableName ($columnTitle,$columnDate,$columnTime) values ('$title','$date','$time')",
    );
    return response;
  }

  Future<int> deletData(String columnid) async {
    Database? db = await database;
    int response = await db!.rawDelete(
      "DELETE FROM $tableName WHERE $columnId = '$columnid'",
    );
    return response;
  }

  Future<int> updateData({
    required String columnid,
    required updatedTitle,
  }) async {
    Database? db = await database;
    int response = await db!.rawUpdate(
      'UPDATE $tableName SET $columnTitle = "$updatedTitle" WHERE$columnId = "$columnid"',
    );
    return response;
  }
}
