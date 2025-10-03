import 'package:equatable/equatable.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/fuel/data/fuel_model.dart';

class FuelState extends Equatable {
  final RequestStatus getFuelState;
  final RequestStatus addFuelState;
  final List<FuelModel> fuels;
  final String fuelErrorMessage;
  final bool isConnected;

  const FuelState({
    this.getFuelState = RequestStatus.initial,
    this.addFuelState = RequestStatus.initial,
    this.fuelErrorMessage = "",
    this.fuels = const [],
    this.isConnected = true,
  });

  FuelState copyWith({
    RequestStatus? getFuelState,
    String? fuelErrorMessage,
    RequestStatus? addFuelState,
    List<FuelModel>? fuels,
    bool? isConnected,
  }) => FuelState(
    getFuelState: getFuelState ?? this.getFuelState,
    fuelErrorMessage: fuelErrorMessage ?? this.fuelErrorMessage,
    addFuelState: addFuelState ?? this.addFuelState,
    fuels: fuels ?? this.fuels,
    isConnected: isConnected ?? this.isConnected,
  );

  @override
  List<Object> get props => [
    getFuelState,
    addFuelState,
    fuelErrorMessage,
    fuels,
    isConnected,
  ];
}
