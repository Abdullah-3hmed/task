import 'package:get_it/get_it.dart';
import 'package:task/core/network/dio_helper.dart';
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
    getIt.registerFactory<TasksCubit>(()=>TasksCubit(tasksRepo: getIt.get<TasksRepo>()));
  }
}
