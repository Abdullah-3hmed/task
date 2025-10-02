import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/services/service_locator.dart';
import 'package:task/tasks/cubit/tasks_cubit.dart';
import 'package:task/tasks/cubit/tasks_state.dart';
import 'package:task/tasks/data/task_model.dart';
import 'package:task/tasks/screens/widgets/add_task_dialog.dart';
import 'package:task/tasks/screens/widgets/task_list_item.dart';
import 'package:task/tasks/screens/widgets/tasks_app_bar.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksCubit>()..getUserTasks(userId: 1),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const TasksAppBar(),
          body: Padding(
            padding: const EdgeInsetsDirectional.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "تقرير المهمات",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: Color(0xFF303A42),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => showAddTaskDialog(context),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12.0,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF5B8C51),
                              size: 20.0,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
                            "اضافة جديد",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14.0,
                              color: Color(0xFF5B8C51),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                const Expanded(child: _TasksList()),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ),
    );
  }

  static ClipRRect _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(32.0),
        topStart: Radius.circular(32.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 12.0,
        selectedItemColor: const Color(0xFF5B8C51),
        unselectedItemColor: const Color(0xFF5B8C51),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12.0,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/info.svg"),
            label: "احصائياتى",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/statics.svg"),
            label: "التقارير",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/user.svg"),
            label: "حسابى",
          ),
        ],
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList();

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
            if(!state.isConnected){
              return NoInternetWidget(
                isLoading: state.tasksState.isLoading,
                errorMessage: state.taskErrorMessage,
                onPressed: (){
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
