import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/widgets/custom_dismissible.dart';
import 'package:task/fuel/cubit/fuel_cubit.dart';
import 'package:task/fuel/data/fuel_model.dart';
import 'package:task/fuel/screens/widgets/edit_fuel_dialog.dart';
import 'package:task/shared/app_cubit/app_cubit.dart';

class FuelListItem extends StatelessWidget {
  const FuelListItem({super.key, required this.fuelModel});

  final FuelModel fuelModel;

  @override
  Widget build(BuildContext context) {
    return CustomDismissible(
      key: ValueKey(fuelModel.id),
      canEdit: fuelModel.canEdit,
      canDelete: fuelModel.canDelete,
      onDelete: () async {
        await context.read<FuelCubit>().deleteFuel(fuelId: fuelModel.id);
      },
      onRequestDelete: () async {
        await context.read<AppCubit>().requestEditDeleteFuel(
          id: fuelModel.id,
          requestEditDelete: RequestEditDeleteEnum.delete,
        );
      },
      onEdit: () {
        showDialog(
          context: context,
          builder: (_) => EditFuelDialog(
            fuelCubit: context.read<FuelCubit>(),
            fuelId: fuelModel.id,
            initialLiters: fuelModel.liters.toDouble(),
          ),
        );
      },
      onRequestEdit: () async{
      await  context.read<AppCubit>().requestEditDeleteFuel(
          id: fuelModel.id,
          requestEditDelete: RequestEditDeleteEnum.edit,
        );
      },
      editMessage:
          "للتعديل على قيمة الوقود تحتاج إلى إذن إدارة التطبيق . هل ترغب فى ذلك ؟",
      deleteMessage:
          "لحذف هذا العنصر تحتاج إلى إذن إدارة التطبيق . هل توافق على ذلك ؟",
      keyValue: ValueKey(fuelModel.id),
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(12.0),
            bottomStart: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.0,
                backgroundColor: const Color(0xFFF4F5F6),
                child: SvgPicture.asset(
                  "assets/images/car.svg",
                  fit: BoxFit.cover,
                  width: 22.0,
                  height: 26.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fuelModel.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "تمت تعبئة : ${fuelModel.liters} لتر",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
