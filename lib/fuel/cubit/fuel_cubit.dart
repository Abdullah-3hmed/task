import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/fuel/repo/fuel_repo.dart';

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
      (fuels) => emit(
        state.copyWith(getFuelState: RequestStatus.success, fuels: fuels),
      ),
    );
  }
}
