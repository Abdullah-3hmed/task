import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/shared/report_cubit/app_state.dart';
import 'package:task/shared/report_repo/report_repo.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({required this.reportRepo}) : super(const ReportState());
  final ReportRepo reportRepo;

  Future<void> requestEditDeleteTask({
    required int id,
    required RequestEditDeleteEnum requestEditDelete,
  }) async {
    emit(state.copyWith(requestEditDeleteState: RequestStatus.loading));
    final result = await reportRepo.requestEditDeleteTask(
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
    final result = await reportRepo.requestEditDeleteFuel(
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
    final result = await reportRepo.requestEditDeleteMaintenance(
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
