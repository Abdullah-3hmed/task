import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/fuel/screens/fuel_screen.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/screens/widgets/maintenance_dialog.dart';
import 'package:task/maintenance/screens/widgets/maintenance_list.dart';
import 'package:task/maintenance/screens/widgets/maintenance_list_item.dart';
import 'package:task/shared/custom_dialog.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MaintenanceCubit maintenanceCubit = getIt<MaintenanceCubit>();
    return BlocProvider.value(
      value: maintenanceCubit..getUserMaintenances()..getSpareParts(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FuelScreen()),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
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
                      onTap: () => showMaintenanceDialog(
                        context,
                        maintenanceCubit: maintenanceCubit,
                      ),
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
                const Expanded(child: MaintenanceList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
