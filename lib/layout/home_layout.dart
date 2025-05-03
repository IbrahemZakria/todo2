import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp2/moduls/screen_widgets/show_bottom_sheet.dart';
import 'package:todoapp2/shared/cubit/appcubit/app_cubit_cubit.dart';
import 'package:todoapp2/shared/cubit/sqflite_cubit/sqflit_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});
  static const String routeName = '/homeLayout';

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubitCubit()),
        BlocProvider(create: (context) => SqflitCubit()..readData()),
      ],
      child: BlocConsumer<AppCubitCubit, AppCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubitCubit cubit = BlocProvider.of<AppCubitCubit>(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
            body: cubit.screens[cubit.currentIndex],

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown == false) {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) {
                        return ShowBottomSheet();
                      })
                      .closed
                      .then((value) {
                        cubit.closedbottomsheet();
                      });
                  cubit.changeFabIcon();
                } else {
                  Navigator.pop(context);
                  cubit.changeFabIcon();
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: false,

              showSelectedLabels: true,
              iconSize: 30,

              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
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
        },
      ),
    );
  }
}
