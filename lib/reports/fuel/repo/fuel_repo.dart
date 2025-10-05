import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/reports/fuel/data/fuel_model.dart';

abstract class FuelRepo {
  Future<Either<Failure, List<FuelModel>>> getFuels();

  Future<Either<Failure, FuelModel>> addFuel({required double numberOfLiters});

  Future<Either<Failure, FuelModel>> editFuel({
    required int fuelId,
    required double numberOfLiters,
  });
  Future<Either<Failure, String>> deleteFuel({required int fuelId});
}
