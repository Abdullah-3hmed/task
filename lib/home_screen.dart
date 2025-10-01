import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/custom_dialog.dart';
import 'package:task/app_constants.dart';
import 'package:task/task_list_item.dart';
import 'package:task/maintenance_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: Image.asset(
              "assets/images/logo.png",
              width: 50.0,
              height: 50.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
              child: Row(
                spacing: 2.0,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFD9D9D9),
                    radius: 20.0,
                    child: Text(
                      "30 كم",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFD9D9D9),
                    radius: 20.0,
                    child: SvgPicture.asset("assets/images/plus.svg"),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFD9D9D9),
                    radius: 20.0,
                    child: Badge(
                      backgroundColor: Colors.transparent,
                      alignment: AlignmentDirectional.topEnd,
                      offset: const Offset(4, -7),
                      label: const CircleAvatar(
                        radius: 4.8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 2.4,
                          backgroundColor: Colors.red,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/notifications-outline.svg',
                        width: 16.0,
                        height: 16.0,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MaintenanceScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5.0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "اضافة مهمة",
                          subTitle:
                              "يمكنك اضافة المهام التي تقوم بها عن طريق نموذج التعبئة التالي",
                          body: _buildTaskDialogBody(),
                          save: (){},
                          finish: (){},
                        ),
                      );
                    },
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
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => TaskListItem(),
                  separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  Column _buildTaskDialogBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        const Text(
          "عنوان المهمة",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
        ),
        const SizedBox(height: 5.0),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE8ECF4),
                width: 1.05,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.indigo, width: 1.05),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: "عنوان المهمة",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          "تاريخ المهمة",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
        ),
        const SizedBox(height: 5.0),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE8ECF4),
                width: 1.05,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.indigo, width: 1.05),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: "تاريخ المهمة (تلقائي)",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          "تفاصيل المهمة",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
        ),
        const SizedBox(height: 5.0),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE8ECF4),
                width: 1.05,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.indigo, width: 1.05),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: "تفاصيل المهمة",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
