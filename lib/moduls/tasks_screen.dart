import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp2/constant.dart';
import 'package:todoapp2/moduls/screen_widgets/task_item.dart';
import 'package:todoapp2/shared/component/UserMessage.dart';
import 'package:todoapp2/shared/cubit/sqflite_cubit/sqflit_cubit.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqflitCubit, SqflitState>(
      listener: (context, state) {
        if (state is SqflitInsertDatabaseState ||
            state is SqflitUpdateDatabaseState ||
            state is SqflitDeleteDatabaseState) {
          BlocProvider.of<SqflitCubit>(context).readData();
        }
      },
      builder: (context, state) {
        SqflitCubit sqflitcubit = BlocProvider.of<SqflitCubit>(context);
        return sqflitcubit.newTasks.isNotEmpty
            ? ListView.builder(
              itemCount: sqflitcubit.newTasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  onDelete: () {
                    sqflitcubit
                        .deletData(
                          (sqflitcubit.newTasks[index][columnId]).toString(),
                        )
                        .then((value) {
                          Usermessage.show(
                            message: "Task deleted successfully",
                          );
                        })
                        .catchError((error) {
                          print('Error deleting data: $error');
                        });
                  },
                  taskTime: sqflitcubit.newTasks[index][columnTime],
                  taskDate: sqflitcubit.newTasks[index][columnDate],
                  taskTitle: sqflitcubit.newTasks[index][columnTitle],
                );
              },
            )
            : Center(child: Text('No data available'));
      },
    );
    // FutureBuilder(
    //   future: sqflite.readData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     } else if (snapshot.hasData) {
    //       tasks = snapshot.data as List<Map>;
    //       return ListView.builder(
    //         itemCount: tasks.length,
    //         itemBuilder: (context, index) {
    //           return TaskItem(
    //             taskTime: tasks[index][columnTime],
    //             taskDate: tasks[index][columnDate],
    //             taskTitle: tasks[index][columnTitle],
    //           );
    //         },
    //       );
    //     } else {
    //       return Center(child: Text('No data available'));
    //     }
    //   },
    // );
  }
}
