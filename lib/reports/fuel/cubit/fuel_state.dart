import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/reports/fuel/data/fuel_model.dart';

class FuelState extends Equatable {
  final RequestStatus getFuelState;
  final RequestStatus addFuelState;
  final RequestStatus editFuelState;
  final RequestStatus deleteFuelState;
  final Map<int, FuelModel> fuels;
  final String fuelErrorMessage;
  final String deleteFuelMessage;
  final bool isConnected;

  const FuelState({
    this.getFuelState = RequestStatus.initial,
    this.addFuelState = RequestStatus.initial,
    this.fuelErrorMessage = "",
    this.fuels = const {},
    this.editFuelState = RequestStatus.initial,
    this.deleteFuelState = RequestStatus.initial,
    this.deleteFuelMessage = "",
    this.isConnected = true,
  });

  FuelState copyWith({
    RequestStatus? getFuelState,
    String? fuelErrorMessage,
    RequestStatus? addFuelState,
    Map<int, FuelModel>? fuels,
    RequestStatus? editFuelState,
    RequestStatus? deleteFuelState,
    String? deleteFuelMessage,
    bool? isConnected,
  }) => FuelState(
    getFuelState: getFuelState ?? this.getFuelState,
    fuelErrorMessage: fuelErrorMessage ?? this.fuelErrorMessage,
    addFuelState: addFuelState ?? this.addFuelState,
    fuels: fuels ?? this.fuels,
    editFuelState: editFuelState ?? this.editFuelState,
    deleteFuelState: deleteFuelState ?? this.deleteFuelState,
    deleteFuelMessage: deleteFuelMessage ?? this.deleteFuelMessage,
    isConnected: isConnected ?? this.isConnected,
  );

  @override
  List<Object> get props => [
    getFuelState,
    addFuelState,
    fuelErrorMessage,
    fuels,
    editFuelState,
    deleteFuelState,
    deleteFuelMessage,
    isConnected,
  ];
}
