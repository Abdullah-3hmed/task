import 'package:equatable/equatable.dart';

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

class MaintenanceItemModel extends Equatable {
  final int carSparePartId;
  final String description;

  const MaintenanceItemModel({
    required this.carSparePartId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {"car_spart_id": carSparePartId, "description": description};
  }

  @override
  List<Object> get props => [carSparePartId, description];
}
