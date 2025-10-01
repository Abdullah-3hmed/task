import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/app_constants.dart';
import 'package:task/custom_dialog.dart';
import 'package:task/maintenance_list_item.dart';
import 'package:task/task_list_item.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "تقرير الصيانة",
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
                          title: "اضافة صيانة",
                          subTitle:
                              "يمكنك اضافة القطع التي قومت بصيانتها عن طريق نموذج التعبئة التالي",
                          body: Container(),
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
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const MaintenanceListItem(),
                  separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                  itemCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
