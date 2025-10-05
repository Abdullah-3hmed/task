import 'package:equatable/equatable.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';

class AddMaintenanceRequestModel extends Equatable {
  final String name;
  final List<MaintenanceItemModel> items;

  const AddMaintenanceRequestModel({required this.items, required this.name});

  Map<String, dynamic> toJson() {
    return {"name": name, "items": items.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object> get props => [name, items];
}

