import 'package:flutter/material.dart';
import 'package:todoapp2/moduls/screen_widgets/task_item.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> tasks = [
      {'time': '10:00 AM', 'date': '2023-10-01', 'title': 'Task 1'},
      {'time': '11:00 AM', 'date': '2023-10-02', 'title': 'Task 2'},
      {'time': '12:00 PM', 'date': '2023-10-03', 'title': 'Task 3'},
    ];
    return ListView.separated(
      itemBuilder:
          (context, index) => TaskItem(
            taskTime: tasks[index]['time'],
            taskDate: tasks[index]['date'],
            taskTitle: tasks[index]['title'],
          ),
      separatorBuilder:
          (context, index) => Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
      itemCount: tasks.length,
    );
  }
}
