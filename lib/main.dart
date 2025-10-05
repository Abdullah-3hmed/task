import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc_observer.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/reports/tasks/screens/tasks_screen.dart';
import 'package:task/shared/report_cubit/report_cubit.dart';

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
      child: BlocProvider(
        create: (context) => getIt<ReportCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppConstants.fontCairo,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
          ),
          home: const TasksScreen(),
        ),
      ),
    );
  }
}
