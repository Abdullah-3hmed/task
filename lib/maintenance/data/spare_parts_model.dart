import 'package:equatable/equatable.dart';

class SparePartsModel extends Equatable {
  final int id;
  final String name;

  const SparePartsModel({required this.id, required this.name});

  factory SparePartsModel.fromJson(Map<String, dynamic> json) =>
      SparePartsModel(id: json["id"] ?? 0, name: json["name"] ?? "");

  @override
  List<Object> get props => [id, name];
}
