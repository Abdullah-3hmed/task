import 'package:equatable/equatable.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';

class AddMaintenanceResponseModel extends Equatable {
  final String message;
  final MaintenanceModel maintenanceModel;

  const AddMaintenanceResponseModel({
    required this.message,
    required this.maintenanceModel,
  });

  factory AddMaintenanceResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMaintenanceResponseModel(
        message: json["message"] ?? "",
        maintenanceModel: MaintenanceModel.fromJson(json["data"] ?? {}),
      );

  @override
  List<Object> get props => [message, maintenanceModel];
}
