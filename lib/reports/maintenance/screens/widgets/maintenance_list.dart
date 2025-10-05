import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/cubit/maintenance_state.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_list_item.dart';

class MaintenanceList extends StatelessWidget {
  const MaintenanceList({super.key});

  static List<MaintenanceModel> dummyMaintenances =
      List<MaintenanceModel>.generate(
        5,
        (context) => const MaintenanceModel(
          id: 0,
          date: "********",
          items: [],
          name: "******",
          canDelete: false,
          canEdit: false,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaintenanceCubit, MaintenanceState>(
      listenWhen: (prev, curr) =>
          prev.maintenanceState != curr.maintenanceState ||
          prev.editMaintenanceState != curr.editMaintenanceState,
      listener: (context, state) {
        if (state.maintenanceState.isError) {
          showToast(
            context: context,
            message: state.maintenanceErrorMessage,
            state: ToastStates.error,
          );
        }
        if (state.editMaintenanceState.isError) {
          showToast(
            context: context,
            message: state.maintenanceErrorMessage,
            state: ToastStates.error,
          );
        }
        if (state.editMaintenanceState.isSuccess) {
          showToast(
            context: context,
            message: state.deleteMaintenanceMessage,
            state: ToastStates.success,
          );
        }
      },
      buildWhen: (prev, curr) =>
          prev.maintenanceState != curr.maintenanceState ||
          prev.maintenances != curr.maintenances,
      builder: (context, state) {
        switch (state.maintenanceState) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: _buildMaintenanceList(maintenances: dummyMaintenances),
            );
          case RequestStatus.success:
            return _buildMaintenanceList(maintenances: state.maintenances);
          case RequestStatus.error:
            if (!state.isConnected) {
              return NoInternetWidget(
                onPressed: () {
                  context.read<MaintenanceCubit>().getUserMaintenances();
                  context.read<MaintenanceCubit>().getSpareParts();
                },
                errorMessage: state.maintenanceErrorMessage,
              );
            }
            return _buildMaintenanceList(maintenances: state.maintenances);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  ListView _buildMaintenanceList({
    required List<MaintenanceModel> maintenances,
  }) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => MaintenanceListItem(
        maintenanceModel: maintenances[index],
        index: index,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: maintenances.length,
    );
  }
}
