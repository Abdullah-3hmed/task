import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/error/server_exception.dart';
import 'package:task/core/network/api_constants.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/utils/safe_api_call.dart';
import 'package:task/tasks/data/task_model.dart';
import 'package:task/tasks/repo/tasks_repo.dart';

class TasksRepoImpl implements TasksRepo {
  final DioHelper dioHelper;

  TasksRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<TaskModel>>> getUserTasks({required int userId}) {
    return safeApiCall<List<TaskModel>>(() async {
      final response = await dioHelper.get(
        headers: {
          "Authorization": "Bearer ${AppConstants.token}",
        },
        url: ApiConstants.getUserTasksEndPoint,
        data: {"ad_id":userId},
      );
      if (response.statusCode == 200) {
        return List<TaskModel>.from(
          (response.data["data"] ?? []).map((x) => TaskModel.fromJson(x)),
        );
      } else {
        throw ServerException(errorMessage: response.data["message"]);
      }
    });
  }
}
