import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/data/add_task_response_model.dart';
import 'package:task/tasks/data/task_model.dart';

class TasksState extends Equatable {
  final RequestStatus tasksState;
  final RequestStatus addTaskState;
  final List<TaskModel> tasks;
  final AddTaskResponseModel addTaskResponseModel;
  final String taskErrorMessage;
  final bool isConnected;

  const TasksState({
    this.tasksState = RequestStatus.initial,
    this.tasks = const [],
    this.taskErrorMessage = "",
    this.addTaskState = RequestStatus.initial,
    this.addTaskResponseModel = AddTaskResponseModel.empty,
    this.isConnected = true,
  });

  TasksState copyWith({
    RequestStatus? tasksState,
    List<TaskModel>? tasks,
    String? taskErrorMessage,
    RequestStatus? addTaskState,
    AddTaskResponseModel? addTaskResponseModel,
    bool? isConnected,
  }) {
    return TasksState(
      tasksState: tasksState ?? this.tasksState,
      tasks: tasks ?? this.tasks,
      taskErrorMessage: taskErrorMessage ?? this.taskErrorMessage,
      addTaskState: addTaskState ?? this.addTaskState,
      addTaskResponseModel: addTaskResponseModel ?? this.addTaskResponseModel,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [
    tasksState,
    tasks,
    taskErrorMessage,
    addTaskState,
    addTaskResponseModel,
    isConnected,
  ];
}
