import 'package:equatable/equatable.dart';

class MaintenanceModel extends Equatable {
  final int id;
  final String name;
  final String date;
  final List<MaintenanceItemModel> items;
  final bool canDelete;
  final bool canEdit;

  const MaintenanceModel({
    required this.id,
    required this.name,
    required this.date,
    required this.items,
    required this.canDelete,
    required this.canEdit,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        date: json["date"] ?? "",
        canDelete: json["can_delete"] ?? false,
        canEdit: json["can_edit"] ?? false,
        items: (json["items"] as List<dynamic>? ?? [])
            .map((item) => MaintenanceItemModel.fromJson(item))
            .toList(),
      );

  @override
  List<Object> get props => [id, name, date, items, canDelete, canEdit];
}

class MaintenanceItemModel extends Equatable {
  final int id;
  final int carSpartId;
  final String description;

  const MaintenanceItemModel({
     this.id = 0,
    required this.description,
    required this.carSpartId,
  });

  factory MaintenanceItemModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceItemModel(
        id: json["id"] ?? 0,
        carSpartId: json["car_spart_id"] ?? 0,
        description: json["description"] ?? "",
      );
Map<String, dynamic> toJson() {
    return {
      "car_spart_id": carSpartId,
      "description": description,
    };
  }
  @override
  List<Object> get props => [id, description, carSpartId];
}
