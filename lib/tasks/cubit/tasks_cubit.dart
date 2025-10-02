import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/cubit/tasks_state.dart';
import 'package:task/tasks/repo/tasks_repo.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({required this.tasksRepo}) : super(const TasksState());
  final TasksRepo tasksRepo;

  Future<void> getUserTasks({required int userId}) async {
    emit(state.copyWith(tasksState: RequestStatus.loading, isConnected: true));
    final result = await tasksRepo.getUserTasks(userId: userId);
    result.fold(
      (failure) {
        if (!failure.isConnected) {
          emit(
            state.copyWith(
              tasksState: RequestStatus.error,
              taskErrorMessage: failure.errorMessage,
              isConnected: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              tasksState: RequestStatus.error,
              taskErrorMessage: failure.errorMessage,
            ),
          );
        }
      },
      (tasks) =>
          emit(state.copyWith(tasksState: RequestStatus.success, tasks: tasks)),
    );
  }
}
