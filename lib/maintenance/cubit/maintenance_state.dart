import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/maintenance/data/maintenance_model.dart';

class MaintenanceState extends Equatable {
  final RequestStatus maintenanceState;
  final String maintenanceErrorMessage;
  final List<MaintenanceModel> maintenances;
  final bool isConnected;


  const MaintenanceState({
    this.maintenanceState = RequestStatus.initial,
    this.maintenanceErrorMessage = "",
    this.maintenances = const [],
    this.isConnected = true,
  });

  MaintenanceState copyWith({
    RequestStatus? maintenanceState,
    String? maintenanceErrorMessage,
    List<MaintenanceModel>? maintenances,
    bool? isConnected,
  }) => MaintenanceState(
    maintenanceState: maintenanceState ?? this.maintenanceState,
    maintenanceErrorMessage:
        maintenanceErrorMessage ?? this.maintenanceErrorMessage,
    maintenances: maintenances ?? this.maintenances,
    isConnected: isConnected ?? this.isConnected,
  );

  @override
  List<Object> get props => [
    maintenanceState,
    maintenanceErrorMessage,
    maintenances,
    isConnected,
  ];
}
