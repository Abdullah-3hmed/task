import 'package:task/core/network/dio_helper.dart';
import 'package:task/fuel/repo/fuel_repo.dart';

class FuelRepoImpl implements FuelRepo {
  final DioHelper dioHelper;

  FuelRepoImpl({required this.dioHelper});
}
