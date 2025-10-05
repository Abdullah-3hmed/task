import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/reports/maintenance/screens/maintenance_screen.dart';

class TasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12.0),
        child: Image.asset("assets/images/logo.png", width: 50.0, height: 50.0),
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
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w900),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}
