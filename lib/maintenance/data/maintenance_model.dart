import 'package:equatable/equatable.dart';

class MaintenanceModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String car;
  final String carSpart;

  const MaintenanceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.car,
    required this.carSpart,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        car: json["car"] ?? "",
        carSpart: json["car_spart"] ?? "",
      );

  @override
  List<Object> get props => [id, name, description, car, carSpart];
}
