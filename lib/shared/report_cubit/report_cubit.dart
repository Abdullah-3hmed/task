import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/reports/fuel/repo/fuel_repo.dart';
import 'package:task/reports/maintenance/repo/maintenance_repo.dart';
import 'package:task/reports/tasks/repo/tasks_repo.dart';
import 'package:task/shared/report_cubit/report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({
    required this.tasksRepo,
    required this.fuelRepo,
    required this.maintenanceRepo,
  }) : super(const ReportState());

  final TasksRepo tasksRepo;
  final FuelRepo fuelRepo;
  final MaintenanceRepo maintenanceRepo;

  Future<void> requestEditDeleteTask({
    required int id,
    required RequestEditDeleteEnum requestEditDelete,
  }) async {
    emit(state.copyWith(requestEditDeleteState: RequestStatus.loading));
    final result = await tasksRepo.requestEditDeleteTask(
      taskId: id,
      requestEditDelete: requestEditDelete,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (requestEditDeleteTaskMessage) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.success,
          message: requestEditDeleteTaskMessage,
        ),
      ),
    );
  }

  Future<void> requestEditDeleteFuel({
    required int id,
    required RequestEditDeleteEnum requestEditDelete,
  }) async {
    emit(state.copyWith(requestEditDeleteState: RequestStatus.loading));
    final result = await fuelRepo.requestEditDeleteFuel(
      fuelId: id,
      requestEditDelete: requestEditDelete,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (requestEditDeleteFuelMessage) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.success,
          message: requestEditDeleteFuelMessage,
        ),
      ),
    );
  }

  Future<void> requestEditDeleteMaintenance({
    required int id,
    required RequestEditDeleteEnum requestEditDelete,
  }) async {
    emit(state.copyWith(requestEditDeleteState: RequestStatus.loading));
    final result = await maintenanceRepo.requestEditDeleteMaintenance(
      fuelId: id,
      requestEditDelete: requestEditDelete,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (requestEditDeleteMaintenanceMessage) => emit(
        state.copyWith(
          requestEditDeleteState: RequestStatus.success,
          message: requestEditDeleteMaintenanceMessage,
        ),
      ),
    );
  }
}
