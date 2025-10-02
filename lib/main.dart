import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task/bloc_observer.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/services/service_locator.dart';
import 'package:task/tasks/screens/tasks_screen.dart';

void main() {
  ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: AppConstants.fontCairo,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        ),
        home: const TasksScreen(),
      ),
    );
  }
}
