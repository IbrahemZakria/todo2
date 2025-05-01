import 'package:flutter/material.dart';
import 'package:todoapp2/shared/local_data_base/sqflite.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Sqflite sqflite = Sqflite();

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            sqflite
                .insertData("insert into notes (title) values ('Task 1')")
                .then((value) {
                  print('Data inserted successfully');
                })
                .catchError((error) {
                  print('Error inserting data: $error');
                });
          },
          child: Text('Add Task'),
        ),
        ElevatedButton(
          onPressed: () {
            sqflite
                .readData()
                .then((value) {
                  print(value.toString());
                })
                .catchError((error) {
                  print('Error reading data: $error');
                });
          },
          child: Text('read Task'),
        ),
        // يمكنك إضافة المزيد من العناصر هنا
      ],
    );
  }
}
