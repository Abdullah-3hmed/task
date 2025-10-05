import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/reports/tasks/cubit/tasks_state.dart';
import 'package:task/reports/tasks/data/add_task_request_model.dart';
import 'package:task/reports/tasks/data/edit_task_request_model.dart';
import 'package:task/reports/tasks/data/start_and_end_task_request_model.dart';
import 'package:task/reports/tasks/data/task_model.dart';
import 'package:task/reports/tasks/repo/tasks_repo.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({required this.tasksRepo}) : super(const TasksState());
  final TasksRepo tasksRepo;

  Future<void> getUserTasks() async {
    emit(state.copyWith(tasksState: RequestStatus.loading, isConnected: true));
    final result = await tasksRepo.getUserTasks();
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
      (tasks) {
        Map<int, TaskModel> taskMap = _generateTasksMap(tasks);
        emit(state.copyWith(tasksState: RequestStatus.success, tasks: taskMap));
      },
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
      (addAndEditTaskResponseModel) {
        emit(
          state.copyWith(
            addTaskState: RequestStatus.success,
            addAndEditTaskResponseModel: addAndEditTaskResponseModel,
            tasks: {
              ...state.tasks,
              addAndEditTaskResponseModel.task.id:
                  addAndEditTaskResponseModel.task,
            },
          ),
        );
      },
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

  Future<void> editTask({
    required EditTaskRequestModel editTaskRequestModel,
  }) async {
    emit(state.copyWith(editTaskState: RequestStatus.loading));
    final result = await tasksRepo.editTask(
      editTaskRequestModel: editTaskRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          editTaskState: RequestStatus.error,
          taskErrorMessage: failure.errorMessage,
        ),
      ),
      (addAndEditTaskResponseModel) {
        final Map<int, TaskModel> updatedTasks = {...state.tasks};
        updatedTasks[addAndEditTaskResponseModel.task.id] =
            addAndEditTaskResponseModel.task;
        emit(
          state.copyWith(
            editTaskState: RequestStatus.success,
            addAndEditTaskResponseModel: addAndEditTaskResponseModel,
            tasks: updatedTasks,
          ),
        );
      },
    );
  }

  Future<void> deleteTask({required int taskId}) async {
    final TasksState oldState = state;
    final Map<int, TaskModel> updatedTasks = {...state.tasks};
    updatedTasks.remove(taskId);
    emit(
      state.copyWith(
        deleteTaskState: RequestStatus.loading,
        tasks: updatedTasks,
      ),
    );
    final result = await tasksRepo.deleteTask(taskId: taskId);
    result.fold(
      (failure) => emit(
        oldState.copyWith(
          deleteTaskState: RequestStatus.error,
          taskErrorMessage: failure.errorMessage,
        ),
      ),
      (deleteTaskMessage) {
        emit(
          state.copyWith(
            deleteTaskState: RequestStatus.success,
            deleteTaskMessage: deleteTaskMessage,
          ),
        );
      },
    );
  }

  Map<int, TaskModel> _generateTasksMap(List<TaskModel> tasks) {
    final Map<int, TaskModel> tasksMap = {};
    for (var task in tasks) {
      tasksMap[task.id] = task;
    }
    return tasksMap;
  }
}
