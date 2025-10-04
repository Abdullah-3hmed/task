import 'package:equatable/equatable.dart';
import 'package:task/tasks/data/task_model.dart';

class AddAndEditTaskResponseModel extends Equatable {
  final String message;
  final TaskModel task;

  const AddAndEditTaskResponseModel({required this.message, required this.task});

  factory AddAndEditTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      AddAndEditTaskResponseModel(
        message: json["message"] ?? "",
        task: TaskModel.fromJson(json["data"] ?? {}),
      );
  static const AddAndEditTaskResponseModel empty = AddAndEditTaskResponseModel(
    message: "",
    task: TaskModel(
      id: 0,
      name: "",
      description: "",
      startDateTime: "",
      endDateTime: "",
      status: "",
      canEdit: false,
      canDelete: false,
    ),
  );

  @override
  List<Object> get props => [message, task];
}
