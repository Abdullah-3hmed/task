import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String startDateTime;
  final String endDateTime;

  const TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? "",
    description: json['description'] ?? "",
    startDateTime: json['start_date_time'] ?? "",
    endDateTime: json['end_date_time'] ?? "",
  );

  @override
  List<Object> get props => [id, name, description, startDateTime, endDateTime];
}
