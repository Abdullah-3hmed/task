import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/fuel/data/fuel_model.dart';

abstract class FuelRepo{
  Future<Either<Failure,List<FuelModel>>> getFuels();
}