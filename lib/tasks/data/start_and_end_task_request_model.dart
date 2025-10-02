import 'package:equatable/equatable.dart';

class StartAndEndTaskRequestModel extends Equatable {
  final int taskId;
  final String startDateTime;
  final String startLocationLang;
  final String startLocationLong;

  const StartAndEndTaskRequestModel({
    required this.taskId,
    required this.startDateTime,
    required this.startLocationLang,
    required this.startLocationLong,
  });

  Map<String, dynamic> toJson() =>
      {
        "task_id": taskId,
        "start_date_time": startDateTime,
        "start_location_lang": startLocationLang,
        "start_location_long": startLocationLong,
      };

  @override
  List<Object> get props =>
      [taskId, startDateTime, startLocationLang, startLocationLong,];
}
