import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/tasks/cubit/tasks_cubit.dart';
import 'package:task/tasks/cubit/tasks_state.dart';
import 'package:task/tasks/data/task_model.dart';
import 'package:task/tasks/screens/widgets/task_list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  static const TaskModel dummyTaskModel = TaskModel(
    id: 1,
    name: "*******",
    description: "************",
    startDateTime: "******",
    endDateTime: "******",
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listenWhen: (prev, cur) => prev.tasksState != cur.tasksState,
      listener: (context, state) {
        if (state.tasksState.isError) {
          showToast(
            context: context,
            message: state.taskErrorMessage,
            state: ToastStates.error,
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
            return _buildTasksList(tasks: state.tasks);
          case RequestStatus.error:
            if (!state.isConnected) {
              return NoInternetWidget(
                isLoading: state.tasksState.isLoading,
                errorMessage: state.taskErrorMessage,
                onPressed: () {
                  context.read<TasksCubit>().getUserTasks(userId: 1);
                },
              );
            }
            return _buildTasksList(tasks: state.tasks);
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
      itemBuilder: (context, index) => TaskListItem(task: tasks[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: tasks.length,
    );
  }
}