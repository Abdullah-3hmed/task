import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/maintenance/data/add_maintenance_item_model.dart';
import 'package:task/maintenance/data/maintenance_model.dart';
import 'package:task/maintenance/data/spare_parts_model.dart';

class MaintenanceState extends Equatable {
  final RequestStatus maintenanceState;
  final RequestStatus getSparePartsState;
  final RequestStatus addMaintenanceState;
  final String addMaintenanceMessage;
  final String maintenanceErrorMessage;
  final List<MaintenanceModel> maintenances;
  final List<SparePartsModel> spareParts;
  final String maintenanceName;
  final List<AddMaintenanceItemModel> maintenanceItems;

  final bool isConnected;


  const MaintenanceState({
    this.maintenanceState = RequestStatus.initial,
    this.maintenanceErrorMessage = "",
    this.maintenances = const [],
    this.spareParts = const [],
    this.getSparePartsState = RequestStatus.loading,
    this.addMaintenanceState = RequestStatus.initial,
    this.addMaintenanceMessage = "",
    this.maintenanceName = "",
    this.maintenanceItems = const [],
    this.isConnected = true,
  });

  MaintenanceState copyWith({
    RequestStatus? maintenanceState,
    String? maintenanceErrorMessage,
    List<MaintenanceModel>? maintenances,
    List<SparePartsModel>? spareParts,
    RequestStatus? getSparePartsState,
    RequestStatus? addMaintenanceState,
    String? addMaintenanceMessage,
    String? maintenanceName,
    List<AddMaintenanceItemModel>? maintenanceItems,
    bool? isConnected,
  }) => MaintenanceState(
    maintenanceState: maintenanceState ?? this.maintenanceState,
    maintenanceErrorMessage:
        maintenanceErrorMessage ?? this.maintenanceErrorMessage,
    maintenances: maintenances ?? this.maintenances,
    spareParts: spareParts ?? this.spareParts,
    getSparePartsState: getSparePartsState ?? this.getSparePartsState,
    addMaintenanceState: addMaintenanceState ?? this.addMaintenanceState,
    addMaintenanceMessage: addMaintenanceMessage ?? this.addMaintenanceMessage,
    maintenanceName: maintenanceName ?? this.maintenanceName,
    maintenanceItems: maintenanceItems ?? this.maintenanceItems,
    isConnected: isConnected ?? this.isConnected,
  );

  @override
  List<Object> get props => [
    maintenanceState,
    maintenanceErrorMessage,
    maintenances,
    spareParts,
    getSparePartsState,
    addMaintenanceState,
    addMaintenanceMessage,
    maintenanceName,
    maintenanceItems,
    isConnected,
  ];
}
