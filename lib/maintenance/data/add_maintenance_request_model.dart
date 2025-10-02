class AddMaintenanceRequestModel {
  final List<MaintenanceItem> items;

  AddMaintenanceRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}

class MaintenanceItem {
  final String name;
  final int carSparePartId;
  final String description;

  MaintenanceItem({
    required this.name,
    required this.carSparePartId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "car_spart_id": carSparePartId,
      "description": description,
    };
  }
}
