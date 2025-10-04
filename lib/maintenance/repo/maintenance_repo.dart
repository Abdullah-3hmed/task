import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/maintenance/data/add_maintenance_request_model.dart';
import 'package:task/maintenance/data/add_maintenance_response_model.dart';
import 'package:task/maintenance/data/edit_maintenance_request_model.dart';
import 'package:task/maintenance/data/maintenance_model.dart';
import 'package:task/maintenance/data/spare_parts_model.dart';

abstract class MaintenanceRepo {
  Future<Either<Failure, List<MaintenanceModel>>> getUserMaintenances();

  Future<Either<Failure, List<SparePartsModel>>> getSpareParts();

  Future<Either<Failure, AddMaintenanceResponseModel>> addMaintenance({
    required AddMaintenanceRequestModel addMaintenanceRequestModel,
  });
  Future<Either<Failure, AddMaintenanceResponseModel>> editMaintenance({
    required EditMaintenanceRequestModel editMaintenanceRequestModel,
  });
  Future<Either<Failure, String>> deleteMaintenance({
    required int id,
  });
}
