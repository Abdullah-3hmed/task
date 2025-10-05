import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/reports/fuel/data/fuel_model.dart';
import 'package:task/reports/fuel/repo/fuel_repo.dart';

import 'fuel_state.dart';

class FuelCubit extends Cubit<FuelState> {
  FuelCubit({required this.fuelRepo}) : super(const FuelState());
  final FuelRepo fuelRepo;

  Future<void> getFuels() async {
    emit(
      state.copyWith(getFuelState: RequestStatus.loading, isConnected: true),
    );
    final result = await fuelRepo.getFuels();
    result.fold(
      (failure) {
        if (!failure.isConnected) {
          emit(
            state.copyWith(
              getFuelState: RequestStatus.error,
              fuelErrorMessage: failure.errorMessage,
              isConnected: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              getFuelState: RequestStatus.error,
              fuelErrorMessage: failure.errorMessage,
            ),
          );
        }
      },
      (fuels) {
        final Map<int, FuelModel> fuelsMap = _generateFuelsMap(fuels);
        emit(
          state.copyWith(getFuelState: RequestStatus.success, fuels: fuelsMap),
        );
      },
    );
  }

  Future<void> addFuel({required double numberOfLiters}) async {
    emit(state.copyWith(addFuelState: RequestStatus.loading));
    final result = await fuelRepo.addFuel(numberOfLiters: numberOfLiters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addFuelState: RequestStatus.error,
          fuelErrorMessage: failure.errorMessage,
        ),
      ),
      (fuelModel) => emit(
        state.copyWith(
          addFuelState: RequestStatus.success,
          fuels: {...state.fuels,fuelModel.id: fuelModel, },
        ),
      ),
    );
  }

  Future<void> editFuel({
    required int fuelId,
    required double numberOfLiters,
  }) async {
    emit(state.copyWith(editFuelState: RequestStatus.loading));
    final result = await fuelRepo.editFuel(
      fuelId: fuelId,
      numberOfLiters: numberOfLiters,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          editFuelState: RequestStatus.error,
          fuelErrorMessage: failure.errorMessage,
        ),
      ),
      (fuelModel) {
        final Map<int, FuelModel> updatedFuels = {...state.fuels};
        updatedFuels[fuelId] = fuelModel;
        emit(
          state.copyWith(
            editFuelState: RequestStatus.success,
            fuels: updatedFuels,
          ),
        );
      },
    );
  }

  Future<void> deleteFuel({required int fuelId}) async {
    final FuelState oldState = state;
    final Map<int, FuelModel> updatedFuels = {...state.fuels};
    updatedFuels.remove(fuelId);
    emit(
      state.copyWith(
        deleteFuelState: RequestStatus.loading,
        fuels: updatedFuels,
      ),
    );
    final result = await fuelRepo.deleteFuel(fuelId: fuelId);
    result.fold(
      (failure) => emit(
        oldState.copyWith(
          deleteFuelState: RequestStatus.error,
          fuelErrorMessage: failure.errorMessage,
        ),
      ),
      (message) => emit(
        state.copyWith(
          deleteFuelState: RequestStatus.success,
          deleteFuelMessage: message,
        ),
      ),
    );
  }

  Map<int, FuelModel> _generateFuelsMap(List<FuelModel> fuels) {
    final Map<int, FuelModel> fuelsMap = {};
    for (final fuel in fuels) {
      fuelsMap[fuel.id] = fuel;
    }
    return fuelsMap;
  }
}
