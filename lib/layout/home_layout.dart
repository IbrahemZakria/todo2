import 'package:flutter/material.dart';
import 'package:todoapp2/moduls/archevied_screen.dart';
import 'package:todoapp2/moduls/done_screen.dart';
import 'package:todoapp2/moduls/screen_widgets/show_bottom_sheet.dart';
import 'package:todoapp2/moduls/tasks_screen.dart';
import 'package:todoapp2/shared/local_data_base/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  static const String routeName = '/homeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [DoneScreen(), TasksScreen(), ArcheviedScreen()];
  List<String> titles = ['Done Tasks', 'Tasks', 'Archevied Tasks'];
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(titles[currentIndex])),
      body: screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Sqflite.createDatabase();
          // Sqflite.getDataFromDatabase()
          //     .then((value) {
          //       print(value.toString());
          //     })
          //     .catchError((error) {
          //       print('error when getting data ${error.toString()}');
          //     });
          if (isBottomSheetShown == false) {
            scaffoldKey.currentState!
                .showBottomSheet((context) {
                  return ShowBottomSheet();
                })
                .closed
                .then((value) {
                  setState(() {
                    fabIcon = Icons.edit;
                  });
                  isBottomSheetShown = false;
                });
            setState(() {
              fabIcon = Icons.close;
            });
            isBottomSheetShown = true;
          } else {
            Navigator.pop(context);
            setState(() {
              fabIcon = Icons.edit;
            });
            isBottomSheetShown = false;
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,

        showSelectedLabels: true,
        iconSize: 30,

        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          // Handle bottom navigation bar tap
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'done'),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'archive',
          ),
        ],
      ),
    );
  }
}
