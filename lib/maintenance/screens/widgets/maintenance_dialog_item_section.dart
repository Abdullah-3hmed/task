import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/cubit/maintenance_state.dart';
import 'package:task/maintenance/data/add_maintenance_request_model.dart';
import 'package:task/maintenance/screens/widgets/maintenance_item_widgets.dart';

class MaintenanceDialogItemSection extends StatelessWidget {
  const MaintenanceDialogItemSection({
    super.key,
    required this.autovalidateMode,
    required this.formKey,
  });

  final ValueNotifier<AutovalidateMode> autovalidateMode;
  final GlobalKey<FormState> formKey;

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
              itemBuilder: (context, index) =>
                  ItemFields(item: state.maintenanceItems[index], index: index),
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
            _SaveButton(formKey: formKey, autovalidateMode: autovalidateMode),
            Expanded(
              child: PrimaryButton(
                text: "الغاء",
                onPressed: () => Navigator.pop(context),
                borderColor: const Color(0xFF5B8C51),
                backgroundColor: Colors.white,
                textColor: const Color(0xFF5B8C51),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.formKey, required this.autovalidateMode});

  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaintenanceCubit, MaintenanceState>(
      listenWhen: (prev, curr) =>
          prev.addMaintenanceState != curr.addMaintenanceState,
      listener: (context, state) {
        if (state.addMaintenanceState.isError) {
          showToast(
            context: context,
            message: state.maintenanceErrorMessage,
            state: ToastStates.error,
          );
        }
        if (state.addMaintenanceState.isSuccess) {
          showToast(
            context: context,
            message: state.addMaintenanceMessage,
            state: ToastStates.success,
          );
          Navigator.pop(context);
        }
      },
      buildWhen: (prev, curr) =>
          prev.addMaintenanceState != curr.addMaintenanceState,
      builder: (context, state) {
        return Expanded(
          child: PrimaryButton(
            isLoading: state.addMaintenanceState.isLoading,
            text: "حفظ التغيرات",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                context.read<MaintenanceCubit>().addMaintenance();
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
