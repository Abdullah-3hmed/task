import 'package:equatable/equatable.dart';
import 'package:task/tasks/data/task_model.dart';

class AddTaskResponseModel extends Equatable {
  final String message;
  final TaskModel task;

  const AddTaskResponseModel({required this.message, required this.task});

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      AddTaskResponseModel(
        message: json["message"] ?? "",
        task: TaskModel.fromJson(json["data"] ?? {}),
      );
  static const AddTaskResponseModel empty = AddTaskResponseModel(
    message: "",
    task: TaskModel(
      id: 0,
      name: "",
      description: "",
      startDateTime: "",
      endDateTime: "",
    ),
  );

  @override
  List<Object> get props => [message, task];
}
