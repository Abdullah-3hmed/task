import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/error/server_exception.dart';
import 'package:task/core/network/api_constants.dart';
import 'package:task/core/network/dio_helper.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/utils/safe_api_call.dart';
import 'package:task/tasks/data/add_task_request_model.dart';
import 'package:task/tasks/data/add_task_response_model.dart';
import 'package:task/tasks/data/start_and_end_task_request_model.dart';
import 'package:task/tasks/data/task_model.dart';
import 'package:task/tasks/repo/tasks_repo.dart';

class TasksRepoImpl implements TasksRepo {
  final DioHelper dioHelper;

  TasksRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<TaskModel>>> getUserTasks({required int userId}) {
    return safeApiCall<List<TaskModel>>(() async {
      final response = await dioHelper.get(
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        url: ApiConstants.getUserTasksEndPoint,
        data: {"ad_id": userId},
      );
      if (response.statusCode == 200) {
        return List<TaskModel>.from(
          (response.data["data"] ?? []).map((x) => TaskModel.fromJson(x)),
        );
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, AddTaskResponseModel>> addTask({
    required AddTaskRequestModel addTaskRequestModel,
  }) async {
    return safeApiCall<AddTaskResponseModel>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.addTaskEndPoint,
        data: addTaskRequestModel.toJson(),
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
      );
      if (response.statusCode == 200) {
        return AddTaskResponseModel.fromJson(response.data);
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, String>> startTask({
    required StartAndEndTaskRequestModel startAndEndTaskRequestModel,
  }) async {
    return safeApiCall<String>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.startTaskEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        data: startAndEndTaskRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }

  @override
  Future<Either<Failure, String>> endTask({
    required StartAndEndTaskRequestModel startAndEndTaskRequestModel,
  }) async {
    return safeApiCall<String>(() async {
      final response = await dioHelper.post(
        url: ApiConstants.endTaskEndpoint,
        headers: {"Authorization": "Bearer ${AppConstants.token}"},
        data: startAndEndTaskRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        throw ServerException(errorMessage: response.data);
      }
    });
  }
}
