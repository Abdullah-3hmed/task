import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/reports/tasks/cubit/tasks_cubit.dart';
import 'package:task/reports/tasks/screens/widgets/add_task_dialog.dart';
import 'package:task/reports/tasks/screens/widgets/tasks_app_bar.dart';
import 'package:task/reports/tasks/screens/widgets/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TasksCubit _tasksCubit = getIt<TasksCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tasksCubit..getUserTasks(userId: 1),
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
                      onTap: () =>
                          showAddTaskDialog(context, cubit: _tasksCubit),
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
                const Expanded(child: TasksList()),
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
