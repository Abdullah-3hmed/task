import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/tasks/data/add_task_request_model.dart';
import 'package:task/tasks/data/add_task_response_model.dart';
import 'package:task/tasks/data/start_and_end_task_request_model.dart';
import 'package:task/tasks/data/task_model.dart';

abstract class TasksRepo {
  Future<Either<Failure, List<TaskModel>>> getUserTasks({required int userId});

  Future<Either<Failure, AddTaskResponseModel>> addTask({
    required AddTaskRequestModel addTaskRequestModel,
  });

  Future<Either<Failure, String>> startTask({
   required StartAndEndTaskRequestModel startAndEndTaskRequestModel,
  });

  Future<Either<Failure, String>> endTask({
    required StartAndEndTaskRequestModel startAndEndTaskRequestModel,

  });
}
