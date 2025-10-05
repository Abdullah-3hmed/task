class AddMaintenanceItemModel {
  int? carSpartId;
  String description;

  AddMaintenanceItemModel({this.carSpartId, this.description = ""});

  AddMaintenanceItemModel copyWith({int? carSpartId, String? description}) =>
      AddMaintenanceItemModel(
        carSpartId: carSpartId ?? this.carSpartId,
        description: description ?? this.description,
      );
}
