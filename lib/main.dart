import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp2/layout/home_layout.dart';
import 'package:todoapp2/shared/bloco_bserver.dart';
import 'package:todoapp2/shared/cubit/appcubit/app_cubit_cubit.dart';
import 'package:todoapp2/shared/cubit/sqflite_cubit/sqflit_cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubitCubit()),
        BlocProvider(create: (context) => SqflitCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routes: {HomeLayout.routeName: (context) => const HomeLayout()},
        initialRoute: HomeLayout.routeName,
      ),
    );
  }
}
