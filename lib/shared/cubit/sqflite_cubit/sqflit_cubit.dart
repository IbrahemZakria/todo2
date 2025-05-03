import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:todoapp2/constant.dart';
part 'sqflit_state.dart';

class SqflitCubit extends Cubit<SqflitState> {
  SqflitCubit() : super(SqflitInitial());
  static SqflitCubit get(context) => BlocProvider.of(context);
  Database? database;
  List<Map> newTasks = [];
  static Database? _database;
  Future<Database> get databased async {
    if (_database == null) {
      _database = await initialDP();
      emit(SqflitCreateDatabaseState());
    }
    return _database!;
  }

  initialDP() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
    print('database created=======================================');
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL)''',
    );
    emit(SqflitCreateDatabaseState());
    print('Table $tableName created');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('upgrade database================');
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
    Database? db = await databased;
    newTasks = await db.rawQuery('SELECT * FROM $tableName');
    emit(SqflitGetDatabaseState());
    return newTasks;
  }

  Future<int> insertData({
    required String title,
    required String date,
    required String time,
  }) async {
    Database? db = await databased;
    int response = await db.rawInsert(
      "insert into $tableName ($columnTitle,$columnDate,$columnTime) values ('$title','$date','$time')",
    );
    emit(SqflitInsertDatabaseState());
    return response;
  }

  Future<int> deletData(String columnid) async {
    Database? db = await databased;
    int response = await db.rawDelete(
      "DELETE FROM $tableName WHERE $columnId = '$columnid'",
    );
    emit(SqflitDeleteDatabaseState());
    return response;
  }

  Future<int> updateData({
    required String columnid,
    required updatedTitle,
  }) async {
    Database? db = await databased;
    int response = await db.rawUpdate(
      'UPDATE $tableName SET $columnTitle = "$updatedTitle" WHERE $columnId = "$columnid"',
    );
    emit(SqflitUpdateDatabaseState());
    return response;
  }

  Future<void> deletedataase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      await deleteDatabase(path);
      print('Database deleted successfully');
      _database = null; // إعادة تعيين مثيل قاعدة البيانات
    } catch (error) {
      print('Error deleting database: $error');
      throw Exception('Failed to delete database');
    }
  }
}
