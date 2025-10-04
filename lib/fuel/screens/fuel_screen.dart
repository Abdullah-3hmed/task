import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/services/service_locator.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/no_internet_widget.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/fuel/cubit/fuel_cubit.dart';
import 'package:task/fuel/cubit/fuel_state.dart';
import 'package:task/fuel/data/fuel_model.dart';
import 'package:task/fuel/screens/widgets/fuel_dialog.dart';
import 'package:task/fuel/screens/widgets/fuel_list_item.dart';
import 'package:task/fuel/screens/widgets/fuels_list.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FuelCubit fuelCubit = getIt<FuelCubit>();
    fuelCubit.getFuels();
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
                Row(
                  children: [
                    const Text(
                      "تقرير تعبئة الوقود",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: Color(0xFF303A42),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => FuelDialog(fuelCubit: fuelCubit),
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
                const Expanded(child: FuelsList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
