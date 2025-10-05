import 'package:dartz/dartz.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/error/server_exception.dart';
import 'package:task/core/network/api_constants.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/utils/safe_api_call.dart';
import 'package:task/reports/maintenance/data/add_maintenance_request_model.dart';
import 'package:task/reports/maintenance/data/add_maintenance_response_model.dart';
import 'package:task/reports/maintenance/data/edit_maintenance_request_model.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/data/spare_parts_model.dart';
import 'package:task/reports/maintenance/repo/maintenance_repo.dart';

class MaintenanceRepoImpl implements MaintenanceRepo {
  final DioHelper dioHelper;

  MaintenanceRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<MaintenanceModel>>> getUserMaintenances() async {
    return safeApiCall<List<MaintenanceModel>>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getUserMaintenancesEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return List<MaintenanceModel>.from(
          (response.data["data"] ?? []).map(
            (x) => MaintenanceModel.fromJson(x),
          ),
        );
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, List<SparePartsModel>>> getSpareParts() async {
    return safeApiCall<List<SparePartsModel>>(() async {
      final response = await dioHelper.get(
        url: ApiConstants.getSparePartsEndPoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return List<SparePartsModel>.from(
          (response.data["data"]?["spare_parts"] ?? []).map(
            (x) => SparePartsModel.fromJson(x),
          ),
        );
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, AddMaintenanceResponseModel>> addMaintenance({
    required AddMaintenanceRequestModel addMaintenanceRequestModel,
  }) async {
    return safeApiCall<AddMaintenanceResponseModel>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.addMaintenanceEndPoint,
        data: addMaintenanceRequestModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return AddMaintenanceResponseModel.fromJson(response.data);
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, AddMaintenanceResponseModel>> editMaintenance({
    required EditMaintenanceRequestModel editMaintenanceRequestModel,
  }) async {
    return safeApiCall<AddMaintenanceResponseModel>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.editMaintenanceEndPoint,
        data: editMaintenanceRequestModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return AddMaintenanceResponseModel.fromJson(response.data);
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, String>> deleteMaintenance({required int id}) async =>
      safeApiCall<String>(() async {
        final response = await dioHelper.post(
          url: ApiConstants.deleteMaintenanceEndPoint,
          data: {"id": id},
          headers: {"Authorization": "Bearer ${AppConstants.token}"},
        );
        if (response.statusCode == 200) {
          return response.data["message"];
        } else {
          throw ServerException(errorMessage: response.data);
        }
      });
  @override
  Future<Either<Failure, String>> requestEditDeleteMaintenance({
    required int fuelId,
    required RequestEditDeleteEnum requestEditDelete,
  }) async => safeApiCall<String>(() async {
    final response = await dioHelper.post(
      url: ApiConstants.requestEditDeleteMaintenanceEndPoint,
      data: {"id": fuelId, "request_type": requestEditDelete.toJson()},
      headers: {"Authorization": "Bearer ${AppConstants.token}"},
    );
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw ServerException(errorMessage: response.data);
    }
  });
}
