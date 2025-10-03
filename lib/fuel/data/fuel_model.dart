import 'package:equatable/equatable.dart';

class FuelModel extends Equatable {
  final int id;
  final String name;
  final String date;

  const FuelModel({required this.id, required this.name, required this.date});

  factory FuelModel.fromJson(Map<String, dynamic> json) => FuelModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    date: json["date"] ?? "",
  );

  @override
  List<Object> get props => [id, name, date];
}
