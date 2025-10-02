import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/tasks/data/task_model.dart';

class TasksState extends Equatable {
  final RequestStatus tasksState;
  final List<TaskModel> tasks;
  final String taskErrorMessage;
  final bool isConnected;

  const TasksState({
    this.tasksState = RequestStatus.initial,
    this.tasks = const [],
    this.taskErrorMessage = "",
    this.isConnected = true,
  });

  TasksState copyWith({
    RequestStatus? tasksState,
    List<TaskModel>? tasks,
    String? taskErrorMessage,
    bool? isConnected,
  }) {
    return TasksState(
      tasksState: tasksState ?? this.tasksState,
      tasks: tasks ?? this.tasks,
      taskErrorMessage: taskErrorMessage ?? this.taskErrorMessage,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [tasksState, tasks, taskErrorMessage, isConnected];
}
