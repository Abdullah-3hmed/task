import 'package:equatable/equatable.dart';
import 'package:task/maintenance/data/add_maintenance_request_model.dart';

class EditMaintenanceRequestModel extends Equatable {
  final int id;
  final String name;
  final List<MaintenanceItemModel> items;

  const EditMaintenanceRequestModel({
    required this.items,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [name, items];
}
