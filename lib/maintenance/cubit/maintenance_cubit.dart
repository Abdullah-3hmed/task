import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/maintenance/cubit/maintenance_state.dart';
import 'package:task/maintenance/data/add_maintenance_item_model.dart';
import 'package:task/maintenance/data/add_maintenance_request_model.dart';
import 'package:task/maintenance/data/edit_maintenance_request_model.dart';
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
          maintenanceItems: [AddMaintenanceItemModel()],
        ),
      ),
    );
  }

  Future<void> getSpareParts() async {
    final result = await maintenanceRepo.getSpareParts();
    result.fold(
      (failure) => emit(
        state.copyWith(
          getSparePartsState: RequestStatus.error,
          maintenanceErrorMessage: failure.errorMessage,
        ),
      ),
      (spareParts) => emit(
        state.copyWith(
          getSparePartsState: RequestStatus.success,
          spareParts: spareParts,
        ),
      ),
    );
  }

  Future<void> addMaintenance() async {
    emit(state.copyWith(addMaintenanceState: RequestStatus.loading));
    final AddMaintenanceRequestModel addMaintenanceRequestModel =
        AddMaintenanceRequestModel(
          name: state.maintenanceName,
          items: state.maintenanceItems.map((item) {
            return MaintenanceItemModel(
              carSparePartId: item.carSpartId ?? 0,
              description: item.description,
            );
          }).toList(),
        );
    final result = await maintenanceRepo.addMaintenance(
      addMaintenanceRequestModel: addMaintenanceRequestModel,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          addMaintenanceState: RequestStatus.error,
          maintenanceErrorMessage: failure.errorMessage,
        ),
      ),
      (addMaintenanceResponseModel) => emit(
        state.copyWith(
          addMaintenanceState: RequestStatus.success,
          addMaintenanceMessage: addMaintenanceResponseModel.message,
          maintenances: [
            ...state.maintenances,
            addMaintenanceResponseModel.maintenanceModel,
          ],
        ),
      ),
    );
  }

  Future<void> editMaintenance({
    required int index,
    required int maintenanceId,
  }) async {
    emit(state.copyWith(editMaintenanceState: RequestStatus.loading));
    final EditMaintenanceRequestModel editMaintenanceRequestModel =
        EditMaintenanceRequestModel(
          id: maintenanceId,
          name: state.maintenanceName,
          items: state.maintenanceItems.map((item) {
            return MaintenanceItemModel(
              carSparePartId: item.carSpartId ?? 0,
              description: item.description,
            );
          }).toList(),
        );
    final result = await maintenanceRepo.editMaintenance(
      editMaintenanceRequestModel: editMaintenanceRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          editMaintenanceState: RequestStatus.error,
          maintenanceErrorMessage: failure.errorMessage,
        ),
      ),
      (addMaintenanceResponseModel) {
        final newMaintenances = [...state.maintenances];
        newMaintenances[index] = addMaintenanceResponseModel.maintenanceModel;
        emit(
          state.copyWith(
            editMaintenanceState: RequestStatus.success,
            addMaintenanceMessage: addMaintenanceResponseModel.message,
            maintenances: newMaintenances,
          ),
        );
      },
    );
  }

  Future<void> deleteMaintenance({required int index, required int id}) async {
    emit(state.copyWith(deleteMaintenanceState: RequestStatus.loading));
    final result = await maintenanceRepo.deleteMaintenance(id: id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteMaintenanceState: RequestStatus.error,
          maintenanceErrorMessage: failure.errorMessage,
        ),
      ),
      (message) {
        final newMaintenances = [...state.maintenances]..removeAt(index);
        emit(
          state.copyWith(
            deleteMaintenanceState: RequestStatus.success,
            deleteMaintenanceMessage: message,
            maintenances: newMaintenances,
          ),
        );
      },
    );
  }

  void updateName(String name) {
    emit(state.copyWith(maintenanceName: name));
  }

  void addMaintenanceItem() {
    emit(
      state.copyWith(
        maintenanceItems: [
          ...state.maintenanceItems,
          AddMaintenanceItemModel(),
        ],
      ),
    );
  }

  void removeMaintenanceItem(int index) {
    final newItems = [...state.maintenanceItems]..removeAt(index);
    emit(state.copyWith(maintenanceItems: newItems));
  }

  void updateMaintenanceItems(
    int index,
    AddMaintenanceItemModel maintenanceItem,
  ) {
    final newItems = [...state.maintenanceItems];
    newItems[index] = maintenanceItem;
    emit(state.copyWith(maintenanceItems: newItems));
  }
}
