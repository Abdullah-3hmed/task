import 'package:dartz/dartz.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/error/server_exception.dart';
import 'package:task/core/network/api_constants.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/utils/safe_api_call.dart';

class ReportRepo {
  final DioHelper dioHelper;

  ReportRepo({required this.dioHelper});

  Future<Either<Failure, String>> requestEditDeleteTask({
    required int taskId,
    required RequestEditDeleteEnum requestEditDelete,
  }) async => safeApiCall<String>(() async {
    final response = await dioHelper.post(
      url: ApiConstants.requestEditDeleteTaskEndPoint,
      data: {"id": taskId, "request_type": requestEditDelete.toJson()},
      headers: {"Authorization": "Bearer ${AppConstants.token}"},
    );
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw ServerException(errorMessage: response.data);
    }
  });

  Future<Either<Failure, String>> requestEditDeleteFuel({
    required int fuelId,
    required RequestEditDeleteEnum requestEditDelete,
  }) async => safeApiCall<String>(() async {
    final response = await dioHelper.post(
      url: ApiConstants.requestEditDeleteFuelEndPoint,
      data: {"id": fuelId, "request_type": requestEditDelete.toJson()},
      headers: {"Authorization": "Bearer ${AppConstants.token}"},
    );
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw ServerException(errorMessage: response.data);
    }
  });

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
