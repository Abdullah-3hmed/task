import 'package:equatable/equatable.dart';

class MaintenanceModel extends Equatable {
  final int id;
  final String name;
  final String date;
  final List<MaintenanceItemModel> items;

  const MaintenanceModel({
    required this.id,
    required this.name,
    required this.date,
    required this.items,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        date: json["date"] ?? "",
        items: (json["items"] as List<dynamic>? ?? [])
            .map((item) => MaintenanceItemModel.fromJson(item))
            .toList(),
      );

  @override
  List<Object> get props => [id, name];
}

class MaintenanceItemModel extends Equatable {
  final int id;
  final String description;

  const MaintenanceItemModel({required this.id, required this.description});

  factory MaintenanceItemModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceItemModel(
        id: json["id"] ?? 0,
        description: json["description"] ?? "",
      );

  @override
  List<Object> get props => [id, description];
}
