part of 'sqflit_cubit.dart';

@immutable
sealed class SqflitState {}

final class SqflitInitial extends SqflitState {}

final class SqflitCreateDatabaseState extends SqflitState {}

final class SqflitInsertDatabaseState extends SqflitState {}

final class SqflitGetDatabaseState extends SqflitState {}

final class SqflitUpdateDatabaseState extends SqflitState {}

final class SqflitDeleteDatabaseState extends SqflitState {}
