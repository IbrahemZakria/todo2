import 'package:sqflite/sqflite.dart';

class Sqflite {
  static Future<void> createDatabase() async {
    await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
            )
            .then((value) {})
            .catchError((error) {
              throw ('error when creating table ${error.toString()}');
            });
      },
      onOpen: (database) {
        print('database opened');
      },
    );
  }

  static Future<void> insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    var database = await openDatabase('todo.db');
    database.transaction((txn) async {
      txn
          .rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
          )
          .then((value) {
            print('inserted successfully');
          })
          .catchError((error) {
            print('error when inserting ${error.toString()}');
          });
    });
  }

  static Future<void> getDataFromDatabase() async {
    var database = await openDatabase('todo.db');
    database
        .rawQuery('SELECT * FROM tasks')
        .then((value) {
          print(value.toString());
        })
        .catchError((error) {
          print('error when getting data ${error.toString()}');
        });
  }

  static Future<void> updateDatabase({
    required String status,
    required int id,
  }) async {
    var database = await openDatabase('todo.db');
    database
        .rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id])
        .then((value) {
          print('updated successfully');
        })
        .catchError((error) {
          print('error when updating ${error.toString()}');
        });
  }

  static Future<void> deleteFromDatabase({required int id}) async {
    var database = await openDatabase('todo.db');
    database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value) {
          print('deleted successfully');
        })
        .catchError((error) {
          print('error when deleting ${error.toString()}');
        });
  }
}
