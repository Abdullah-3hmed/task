import 'package:equatable/equatable.dart';

class FuelModel extends Equatable {
  final int id;
  final num liters;
  final String date;
  final bool canEdit;
  final bool canDelete;

  const FuelModel({
    required this.id,
    required this.liters,
    required this.date,
    required this.canEdit,
    required this.canDelete,
  });

  factory FuelModel.fromJson(Map<String, dynamic> json) => FuelModel(
    id: json["id"] ?? 0,
    liters: json["name"] ?? 0.0,
    date: json["date"] ?? "",
    canEdit: json["can_edit"] ?? false,
    canDelete: json["can_delete"] ?? false,
  );

  @override
  List<Object> get props => [id, liters, date, canEdit, canDelete];
}
