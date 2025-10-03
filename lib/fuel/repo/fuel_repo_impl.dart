import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/error/server_exception.dart';
import 'package:task/core/network/api_constants.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/utils/safe_api_call.dart';
import 'package:task/fuel/data/fuel_model.dart';
import 'package:task/fuel/repo/fuel_repo.dart';

class FuelRepoImpl implements FuelRepo {
  final DioHelper dioHelper;

  FuelRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<FuelModel>>> getFuels() async{
   return safeApiCall(()async{
     final response = await dioHelper.get(
       url: ApiConstants.getUserFuelsEndPoint,
       headers: {"Authorization": "Bearer ${AppConstants.token}"},
     );
     if(response.statusCode == 200){
       return List<FuelModel>.from(
         (response.data["data"] ?? []).map((x) => FuelModel.fromJson(x)),
       );
     }else{
       throw ServerException(errorMessage: response.data);
     }
   });
  }
}
