import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/reports/maintenance/data/add_maintenance_item_model.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/data/spare_parts_model.dart';

class MaintenanceState extends Equatable {
  final RequestStatus maintenanceState;
  final RequestStatus getSparePartsState;
  final RequestStatus addMaintenanceState;
  final RequestStatus editMaintenanceState;
  final RequestStatus deleteMaintenanceState;
  final String addMaintenanceMessage;
  final String deleteMaintenanceMessage;
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
    this.editMaintenanceState = RequestStatus.initial,
    this.deleteMaintenanceState = RequestStatus.initial,
    this.deleteMaintenanceMessage = "",
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
    RequestStatus? editMaintenanceState,
    RequestStatus? deleteMaintenanceState,
    String? deleteMaintenanceMessage,
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
    editMaintenanceState: editMaintenanceState ?? this.editMaintenanceState,
    deleteMaintenanceState:
        deleteMaintenanceState ?? this.deleteMaintenanceState,
    deleteMaintenanceMessage:
        deleteMaintenanceMessage ?? this.deleteMaintenanceMessage,
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
    editMaintenanceState,
    deleteMaintenanceState,
    deleteMaintenanceMessage,
    isConnected,
  ];
}
