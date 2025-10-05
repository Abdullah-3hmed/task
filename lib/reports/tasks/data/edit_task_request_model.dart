import 'package:equatable/equatable.dart';

class EditTaskRequestModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String date;

  const EditTaskRequestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "start_date_time": date,
  };

  @override
  List<Object> get props => [id, name, description, date];
}
