import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/screens/widgets/edit_maintenance_dialog_body.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_dialog_body.dart';

class EditMaintenanceDialog extends StatefulWidget {
  const EditMaintenanceDialog({
    super.key,
    required this.maintenanceCubit,
    required this.maintenanceModel,
  });

  final MaintenanceCubit maintenanceCubit;
  final MaintenanceModel maintenanceModel;

  @override
  State<EditMaintenanceDialog> createState() => _EditMaintenanceDialogState();
}

class _EditMaintenanceDialogState extends State<EditMaintenanceDialog> {
  late final GlobalKey<FormState> formKey;
  late ValueNotifier<AutovalidateMode> autovalidateMode;
  late final TextEditingController nameController;

  @override
  void initState() {
    widget.maintenanceCubit.initForEdit(widget.maintenanceModel);
    formKey = GlobalKey<FormState>();
    autovalidateMode = ValueNotifier<AutovalidateMode>(
      AutovalidateMode.disabled,
    );
    nameController = TextEditingController(text: widget.maintenanceModel.name);
    super.initState();
  }
@override
  void dispose() {
    nameController.dispose();
    autovalidateMode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.maintenanceCubit,
      child: Dialog(
        insetPadding: const EdgeInsets.all(20.0),
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(20.0),
                child: ValueListenableBuilder<AutovalidateMode>(
                  valueListenable: autovalidateMode,
                  builder: (context, mode, _) {
                    return Form(
                      key: formKey,
                      autovalidateMode: mode,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          "تعديل صيانة",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        "يمكنك تعديل القطع التي قومت بصيانتها عن طريق نموذج التعبئة التالي",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "عنوان",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: "عنوان",
                        onSaved: (value) {
                          context.read<MaintenanceCubit>().updateName(
                            value!,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      EditMaintenanceDialogBody(
                        autovalidateMode: autovalidateMode,
                        formKey: formKey,
                        maintenanceId: widget.maintenanceModel.id,
                      ),
                    ],
                  ),
                      ),
                    );
                  },
                ),
              ),
            ),
            PositionedDirectional(
              top: 26.0,
              end: 26.0,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showEditMaintenanceDialog(
  BuildContext context, {
  required MaintenanceCubit maintenanceCubit,
  required MaintenanceModel maintenanceModel,
}) {
  showDialog(
    context: context,
    builder: (_) => EditMaintenanceDialog(
      maintenanceCubit: maintenanceCubit,
      maintenanceModel: maintenanceModel,
    ),
  );
}
