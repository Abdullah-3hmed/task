import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/data/add_task_response_model.dart';
import 'package:task/tasks/data/task_model.dart';

class TasksState extends Equatable {
  final RequestStatus tasksState;
  final RequestStatus addTaskState;
  final RequestStatus startTaskState;
  final RequestStatus endTaskState;
  final String startTaskMessage;
  final String endTaskMessage;
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
    this.startTaskState = RequestStatus.initial,
    this.endTaskState = RequestStatus.initial,
    this.startTaskMessage = "",
    this.endTaskMessage = "",
    this.isConnected = true,
  });

  TasksState copyWith({
    RequestStatus? tasksState,
    List<TaskModel>? tasks,
    String? taskErrorMessage,
    RequestStatus? addTaskState,
    AddTaskResponseModel? addTaskResponseModel,
    RequestStatus? startTaskState,
    RequestStatus? endTaskState,
    String? startTaskMessage,
    String? endTaskMessage,
    bool? isConnected,
  }) {
    return TasksState(
      tasksState: tasksState ?? this.tasksState,
      tasks: tasks ?? this.tasks,
      taskErrorMessage: taskErrorMessage ?? this.taskErrorMessage,
      addTaskState: addTaskState ?? this.addTaskState,
      addTaskResponseModel: addTaskResponseModel ?? this.addTaskResponseModel,
      startTaskState: startTaskState ?? this.startTaskState,
      endTaskState: endTaskState ?? this.endTaskState,
      startTaskMessage: startTaskMessage ?? this.startTaskMessage,
      endTaskMessage: endTaskMessage ?? this.endTaskMessage,
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
    startTaskState,
    endTaskState,
    startTaskMessage,
    endTaskMessage,
    isConnected,
  ];
}
