import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/maintenance/data/maintenance_model.dart';

abstract class MaintenanceRepo {
  Future<Either<Failure, List<MaintenanceModel>>> getUserMaintenances();
}
