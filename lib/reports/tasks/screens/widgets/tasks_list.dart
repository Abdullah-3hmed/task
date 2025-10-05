import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/reports/tasks/cubit/tasks_cubit.dart';
import 'package:task/reports/tasks/cubit/tasks_state.dart';
import 'package:task/reports/tasks/data/task_model.dart';
import 'package:task/reports/tasks/screens/widgets/task_list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  static const TaskModel dummyTaskModel = TaskModel(
    id: 1,
    name: "*******",
    description: "************",
    startDateTime: "******",
    endDateTime: "******",
    canEdit: false,
    canDelete: false,
    status: "******",
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listenWhen: (prev, cur) =>
          prev.tasksState != cur.tasksState ||
          prev.deleteTaskState != cur.deleteTaskState,
      listener: (context, state) {
        if (state.tasksState.isError) {
          showToast(
            context: context,
            message: state.taskErrorMessage,
            state: ToastStates.error,
          );
        }
        if (state.deleteTaskState.isError) {
          showToast(
            context: context,
            message: state.taskErrorMessage,
            state: ToastStates.error,
          );
        }
        if (state.deleteTaskState.isSuccess) {
          showToast(
            context: context,
            message: state.deleteTaskMessage,
            state: ToastStates.success,
          );
        }
      },
      buildWhen: (prev, cur) =>
          prev.tasksState != cur.tasksState || prev.tasks != cur.tasks,
      builder: (context, state) {
        switch (state.tasksState) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    const TaskListItem(task: dummyTaskModel),
                separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                itemCount: 10,
              ),
            );
          case RequestStatus.success:
            return state.tasks.isEmpty
                ? const Center(
                    child: Text(
                      "ليس لديك مهمات فى الوقت الحالى",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : _buildTasksList(tasks: state.tasks.values.toList());
          case RequestStatus.error:
            if (!state.isConnected) {
              return NoInternetWidget(
                errorMessage: state.taskErrorMessage,
                onPressed: () {
                  context.read<TasksCubit>().getUserTasks(userId: 1);
                },
              );
            }
            return state.tasks.isEmpty
                ? const Center(
                    child: Text(
                      "ليس لديك مهمات فى الوقت الحالى",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : _buildTasksList(tasks: state.tasks.values.toList());
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  ListView _buildTasksList({required List<TaskModel> tasks}) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      cacheExtent: 200.0,
      itemBuilder: (context, index) =>
          TaskListItem(key: ValueKey(tasks[index].id), task: tasks[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: tasks.length,
    );
  }
}
