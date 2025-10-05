import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/core/utils/assets_manager.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/custom_header.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/fuel/cubit/fuel_cubit.dart';
import 'package:task/reports/fuel/screens/widgets/fuel_dialog.dart';
import 'package:task/reports/fuel/screens/widgets/fuels_list.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FuelCubit fuelCubit = getIt<FuelCubit>();
    return BlocProvider.value(
      value: fuelCubit..getFuels(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsetsDirectional.all(24.0),
            child: Column(
              children: [
                CustomHeaderTitle(
                  title: "تقرير تعبئة الوقود",
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => FuelDialog(fuelCubit: fuelCubit),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Expanded(child: FuelsList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
