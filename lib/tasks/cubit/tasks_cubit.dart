import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/cubit/tasks_state.dart';
import 'package:task/tasks/data/add_task_request_model.dart';
import 'package:task/tasks/data/start_and_end_task_request_model.dart';
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

  Future<void> addTask({
    required AddTaskRequestModel addTaskRequestModel,
  }) async {
    emit(state.copyWith(addTaskState: RequestStatus.loading));
    final result = await tasksRepo.addTask(
      addTaskRequestModel: addTaskRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          addTaskState: RequestStatus.error,
          taskErrorMessage: failure.errorMessage,
        ),
      ),
      (addTaskResponseModel) => emit(
        state.copyWith(
          addTaskState: RequestStatus.success,
          addTaskResponseModel: addTaskResponseModel,
          tasks: [...state.tasks, addTaskResponseModel.task],
        ),
      ),
    );
  }

  Future<void> startTask({
    required StartAndEndTaskRequestModel startAndEndTaskRequestModel,
  }) async {
    emit(state.copyWith(startTaskState: RequestStatus.loading));
    final result = await tasksRepo.startTask(
      startAndEndTaskRequestModel: startAndEndTaskRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          startTaskState: RequestStatus.error,
          taskErrorMessage: failure.errorMessage,
        ),
      ),
      (startTaskMessage) => emit(
        state.copyWith(
          startTaskState: RequestStatus.success,
          startTaskMessage: startTaskMessage,
        ),
      ),
    );
  }

  Future<void> endTask({
    required StartAndEndTaskRequestModel startAndEndTaskRequestModel,
  }) async {
    emit(state.copyWith(startTaskState: RequestStatus.loading));
    final result = await tasksRepo.endTask(
      startAndEndTaskRequestModel: startAndEndTaskRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          endTaskState: RequestStatus.error,
          taskErrorMessage: failure.errorMessage,
        ),
      ),
      (endTaskMessage) => emit(
        state.copyWith(
          endTaskState: RequestStatus.success,
          endTaskMessage: endTaskMessage,
        ),
      ),
    );
  }
}
