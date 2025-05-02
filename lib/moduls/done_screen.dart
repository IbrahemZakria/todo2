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
                .insertData(
                  title: 'Task 22',
                  date: '2023-10-01',
                  time: '10:00 AM',
                )
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
        ElevatedButton(
          onPressed: () {
            sqflite
                .deletData("DELETE FROM notes WHERE title = 'Task 22'")
                .then((value) {
                  print(value.toString());
                })
                .catchError((error) {
                  print('Error reading data: $error');
                });
          },
          child: Text('delete Task'),
        ),
        ElevatedButton(
          onPressed: () {
            sqflite
                .updateData(columnid: '5', updatedTitle: "ewc")
                .then((value) {
                  print(value.toString());
                })
                .catchError((error) {
                  print('Error reading data: $error');
                });
          },
          child: Text('update Task'),
        ),
        // يمكنك إضافة المزيد من العناصر هنا
      ],
    );
  }
}
