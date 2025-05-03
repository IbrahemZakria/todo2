import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    super.key,
    required this.taskTime,
    required this.taskDate,
    required this.taskTitle,
    required this.onDelete,
  });
  String taskTime;
  String taskDate;
  String taskTitle;
  Function onDelete;
  Function? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 227, 227, 227),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Text(taskTime, style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(taskDate, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              onDelete();
            },
            icon: Icon(Icons.delete, color: Colors.red, size: 60),
          ),
        ],
      ),
    );
  }
}
