import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/maintenance/cubit/maintenance_state.dart';
import 'package:task/maintenance/repo/maintenance_repo.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  MaintenanceCubit({required this.maintenanceRepo})
    : super(const MaintenanceState());
  final MaintenanceRepo maintenanceRepo;

  Future<void> getUserMaintenances() async {
    emit(
      state.copyWith(
        maintenanceState: RequestStatus.loading,
        isConnected: true,
      ),
    );
    final result = await maintenanceRepo.getUserMaintenances();
    result.fold(
      (failure) {
        if (!failure.isConnected) {
          emit(
            state.copyWith(
              maintenanceState: RequestStatus.error,
              maintenanceErrorMessage: failure.errorMessage,
              isConnected: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              maintenanceState: RequestStatus.error,
              maintenanceErrorMessage: failure.errorMessage,
            ),
          );
        }
      },
      (maintenances) => emit(
        state.copyWith(
          maintenanceState: RequestStatus.success,
          maintenances: maintenances,
        ),
      ),
    );
  }
}
