import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/fuel/cubit/fuel_cubit.dart';
import 'package:task/fuel/cubit/fuel_state.dart';
import 'package:task/fuel/data/fuel_model.dart';
import 'package:task/fuel/screens/widgets/fuel_list_item.dart';

class FuelsList extends StatelessWidget {
  const FuelsList({super.key});

  static List<FuelModel> dummyFuels = List<FuelModel>.generate(
    5,
    (context) => const FuelModel(id: 0, name: 0.0, date: '********'),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FuelCubit, FuelState>(
      listenWhen: (prev, curr) => prev.getFuelState != curr.getFuelState,
      listener: (context, state) {
        if (state.getFuelState.isError) {
          showToast(
            context: context,
            message: state.fuelErrorMessage,
            state: ToastStates.error,
          );
        }
      },
      buildWhen: (prev, curr) =>
          prev.getFuelState != curr.getFuelState || prev.fuels != curr.fuels,
      builder: (context, state) {
        switch (state.getFuelState) {
          case RequestStatus.loading:
            return Skeletonizer(child: _buildFuelList(fuels: dummyFuels));
          case RequestStatus.success:
            return _buildFuelList(fuels: state.fuels);
          case RequestStatus.error:
            if (!state.isConnected) {
              return NoInternetWidget(
                onPressed: () {
                  context.read<FuelCubit>().getFuels();
                },
                errorMessage: state.fuelErrorMessage,
              );
            } else {
              return _buildFuelList(fuels: state.fuels);
            }
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  ListView _buildFuelList({required List<FuelModel> fuels}) {
    return ListView.separated(
      cacheExtent: 200,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => FuelListItem(fuelModel: fuels[index]),
      separatorBuilder: (_, _) => const SizedBox(height: 24.0),
      itemCount: fuels.length,
    );
  }
}
