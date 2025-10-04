import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/data/add_and_edit_task_response_model.dart';
import 'package:task/tasks/data/task_model.dart';

class TasksState extends Equatable {
  final RequestStatus tasksState;
  final RequestStatus addTaskState;
  final RequestStatus startTaskState;
  final RequestStatus endTaskState;
  final RequestStatus editTaskState;
  final RequestStatus deleteTaskState;
  final String startTaskMessage;
  final String deleteTaskMessage;
  final String endTaskMessage;
  final Map<int,TaskModel>tasks;
  final AddAndEditTaskResponseModel addAndEditTaskResponseModel;
  final String taskErrorMessage;
  final bool isConnected;

  const TasksState({
    this.tasksState = RequestStatus.initial,
    this.tasks = const {},
    this.taskErrorMessage = "",
    this.addTaskState = RequestStatus.initial,
    this.addAndEditTaskResponseModel = AddAndEditTaskResponseModel.empty,
    this.startTaskState = RequestStatus.initial,
    this.endTaskState = RequestStatus.initial,
    this.startTaskMessage = "",
    this.endTaskMessage = "",
    this.editTaskState = RequestStatus.initial,
    this.deleteTaskState = RequestStatus.initial,
    this.deleteTaskMessage = "",
    this.isConnected = true,
  });

  TasksState copyWith({
    RequestStatus? tasksState,
      Map<int,TaskModel>? tasks,
    String? taskErrorMessage,
    RequestStatus? addTaskState,
    AddAndEditTaskResponseModel? addAndEditTaskResponseModel,
    RequestStatus? startTaskState,
    RequestStatus? endTaskState,
    String? startTaskMessage,
    String? endTaskMessage,
    RequestStatus? editTaskState,
    RequestStatus? requestEditDeleteTaskState,
    String? requestEditDeleteTaskMessage,
    RequestStatus? deleteTaskState,
    String? deleteTaskMessage,
    bool? isConnected,
  }) {
    return TasksState(
      tasksState: tasksState ?? this.tasksState,
      tasks: tasks ?? this.tasks,
      taskErrorMessage: taskErrorMessage ?? this.taskErrorMessage,
      addTaskState: addTaskState ?? this.addTaskState,
      addAndEditTaskResponseModel: addAndEditTaskResponseModel ?? this.addAndEditTaskResponseModel,
      startTaskState: startTaskState ?? this.startTaskState,
      endTaskState: endTaskState ?? this.endTaskState,
      startTaskMessage: startTaskMessage ?? this.startTaskMessage,
      endTaskMessage: endTaskMessage ?? this.endTaskMessage,
      editTaskState: editTaskState ?? this.editTaskState,
      deleteTaskState: deleteTaskState ?? this.deleteTaskState,
      deleteTaskMessage: deleteTaskMessage ?? this.deleteTaskMessage,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [
    tasksState,
    tasks,
    taskErrorMessage,
    addTaskState,
    addAndEditTaskResponseModel,
    startTaskState,
    endTaskState,
    startTaskMessage,
    endTaskMessage,
    editTaskState,
    deleteTaskState,
    deleteTaskMessage,
    isConnected,
  ];
}
