import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp2/moduls/archevied_screen.dart';
import 'package:todoapp2/moduls/done_screen.dart';
import 'package:todoapp2/moduls/tasks_screen.dart';

part 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  static AppCubitCubit get(context) => BlocProvider.of(context);
  AppCubitCubit() : super(AppCubitInitial());
  int currentIndex = 0;

  List<Widget> screens = [DoneScreen(), TasksScreen(), ArcheviedScreen()];

  List<String> titles = ['Done Tasks', 'Tasks', 'Archevied Tasks'];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppCubitChangeBottomNavBarState(index));
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeFabIcon() {
    if (isBottomSheetShown == false) {
      fabIcon = Icons.close;
      isBottomSheetShown = true;
      emit(AppCubitChangeBottomSheetState(isBottomSheetShown, fabIcon));
    } else {
      fabIcon = Icons.edit;
      isBottomSheetShown = false;
      emit(AppCubitChangeBottomSheetState(isBottomSheetShown, fabIcon));
    }
  }

  void closedbottomsheet() {
    isBottomSheetShown = false;
    fabIcon = Icons.edit;
    emit(closedBottomSheetState(isBottomSheetShown, fabIcon));
  }
}
