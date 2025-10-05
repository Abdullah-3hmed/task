import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/assets_manager.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/cubit/maintenance_state.dart';
import 'package:task/reports/maintenance/screens/widgets/edit_maintenance_item_fields.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_item_fields.dart';

class EditMaintenanceDialogBody extends StatelessWidget {
  const EditMaintenanceDialogBody({
    super.key,
    required this.autovalidateMode,
    required this.formKey,
    required this.maintenanceId,
    required this.index,
  });

  final ValueNotifier<AutovalidateMode> autovalidateMode;
  final GlobalKey<FormState> formKey;
  final int maintenanceId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<MaintenanceCubit, MaintenanceState>(
          buildWhen: (prev, curr) =>
              prev.maintenanceItems != curr.maintenanceItems,
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              cacheExtent: 200,
              itemBuilder: (context, index) => EditMaintenanceItemFields(
                key: ValueKey(index),
                item: state.maintenanceItems[index],
                index: index,
              ),
              itemCount: state.maintenanceItems.length,
            );
          },
        ),
        TextButton(
          onPressed: () =>
              context.read<MaintenanceCubit>().addMaintenanceItem(),
          child: const Text(
            "+ اضافة عنصر جديد",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        Row(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SaveButton(
              formKey: formKey,
              autovalidateMode: autovalidateMode,
              maintenanceId: maintenanceId,
              index: index,
            ),
            Expanded(
              child: PrimaryButton(
                text: "الغاء",
                onPressed: () => Navigator.pop(context),
                borderColor: AssetsManager.primaryColor,
                backgroundColor: Colors.white,
                textColor: AssetsManager.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.formKey,
    required this.autovalidateMode,
    required this.maintenanceId,
    required this.index,
  });

  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> autovalidateMode;
  final int maintenanceId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaintenanceCubit, MaintenanceState>(
      listenWhen: (prev, curr) =>
          prev.editMaintenanceState != curr.editMaintenanceState,
      listener: (context, state) {
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
            message: "تم تعديل البيانات بنجاح",
            state: ToastStates.success,
          );
          Navigator.pop(context);
        }
      },
      buildWhen: (prev, curr) =>
          prev.editMaintenanceState != curr.editMaintenanceState,
      builder: (context, state) {
        return Expanded(
          child: PrimaryButton(
            isLoading: state.editMaintenanceState.isLoading,
            text: "حفظ التغيرات",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                context.read<MaintenanceCubit>().editMaintenance(
                  maintenanceId: maintenanceId,
                  index: index,
                );
              } else {
                autovalidateMode.value = AutovalidateMode.always;
              }
            },
          ),
        );
      },
    );
  }
}
