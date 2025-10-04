import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/shared/app_cubit/app_state.dart';
import 'package:task/shared/app_repo/app_repo.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.appRepo}) : super(const AppState());
  final AppRepo appRepo;

  Future<void> requestEditDeleteTask({
    required int id,
    required RequestEditDeleteEnum requestEditDelete,
  }) async {
    emit(state.copyWith(requestEditDeleteState: RequestStatus.loading));
    final result = await appRepo.requestEditDeleteTask(
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
    final result = await appRepo.requestEditDeleteFuel(
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
}
