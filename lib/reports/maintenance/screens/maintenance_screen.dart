import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/core/utils/assets_manager.dart';
import 'package:task/core/widgets/custom_header.dart';
import 'package:task/reports/fuel/screens/fuel_screen.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_dialog.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_list.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_list_item.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MaintenanceCubit maintenanceCubit = getIt<MaintenanceCubit>();
    return BlocProvider.value(
      value: maintenanceCubit
        ..getUserMaintenances()
        ..getSpareParts(),
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
                CustomHeaderTitle(
                  title: "تقرير الصيانة",
                  onPressed: () => showMaintenanceDialog(
                    context,
                    maintenanceCubit: maintenanceCubit,
                  ),
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
