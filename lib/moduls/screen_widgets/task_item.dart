import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    super.key,
    required this.taskTime,
    required this.taskDate,
    required this.taskTitle,
  });
  String taskTime;
  String taskDate;
  String taskTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        ],
      ),
    );
  }
}
