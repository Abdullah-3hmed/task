import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/tasks/data/task_model.dart';

abstract class TasksRepo {
  Future<Either<Failure, List<TaskModel>>> getUserTasks({required int userId});
}