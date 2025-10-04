import 'package:get_it/get_it.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/fuel/cubit/fuel_cubit.dart';
import 'package:task/fuel/repo/fuel_repo.dart';
import 'package:task/fuel/repo/fuel_repo_impl.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/repo/maintenance_repo.dart';
import 'package:task/maintenance/repo/maintenance_repo_impl.dart';
import 'package:task/shared/app_cubit/app_cubit.dart';
import 'package:task/shared/app_repo/app_repo.dart';
import 'package:task/tasks/cubit/tasks_cubit.dart';
import 'package:task/tasks/repo/tasks_repo.dart';
import 'package:task/tasks/repo/tasks_repo_impl.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerLazySingleton<DioHelper>(() => DioHelper());
    getIt.registerLazySingleton<TasksRepo>(
      () => TasksRepoImpl(dioHelper: getIt.get<DioHelper>()),
    );
    getIt.registerFactory<TasksCubit>(
      () => TasksCubit(tasksRepo: getIt.get<TasksRepo>()),
    );
    getIt.registerLazySingleton<MaintenanceRepo>(
      () => MaintenanceRepoImpl(dioHelper: getIt.get<DioHelper>()),
    );
    getIt.registerFactory<MaintenanceCubit>(
      () => MaintenanceCubit(maintenanceRepo: getIt.get<MaintenanceRepo>()),
    );
    getIt.registerLazySingleton<FuelRepo>(
          () => FuelRepoImpl(dioHelper: getIt.get<DioHelper>()),
    );
    getIt.registerFactory<FuelCubit>(
          () => FuelCubit(fuelRepo: getIt.get<FuelRepo>()),
    );
    getIt.registerLazySingleton<AppRepo>(
          () => AppRepo(dioHelper: getIt.get<DioHelper>()),
    );
    getIt.registerFactory<AppCubit>(
          () => AppCubit(appRepo: getIt.get<AppRepo>()),
    );
  }
}
