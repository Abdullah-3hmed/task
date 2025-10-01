import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/home/widgets/add_task_dialog.dart';
import 'package:task/home/widgets/home_app_bar.dart';
import 'package:task/home/widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body:  Padding(
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
              const Expanded(
                child: _TasksList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  static BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
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
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => TaskListItem(),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: 10,
    );
  }
}
