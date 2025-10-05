import 'package:equatable/equatable.dart';

class AddTaskRequestModel extends Equatable {
  final String name;
  final String description;
  final String date;

  const AddTaskRequestModel({
    required this.name,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "start_date_time": date,
  };

  @override
  List<Object> get props => [name, description, date];
}
