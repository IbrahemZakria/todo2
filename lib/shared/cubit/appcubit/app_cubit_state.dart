part of 'app_cubit_cubit.dart';

@immutable
sealed class AppCubitState {}

final class AppCubitInitial extends AppCubitState {}

final class AppCubitChangeBottomNavBarState extends AppCubitState {
  final int index;

  AppCubitChangeBottomNavBarState(this.index);
}

final class AppCubitChangeBottomSheetState extends AppCubitState {
  final bool isBottomSheetShown;
  final IconData fabIcon;

  AppCubitChangeBottomSheetState(this.isBottomSheetShown, this.fabIcon);
}

final class closedBottomSheetState extends AppCubitState {
  final bool isBottomSheetShown;
  final IconData fabIcon;

  closedBottomSheetState(this.isBottomSheetShown, this.fabIcon);
}
