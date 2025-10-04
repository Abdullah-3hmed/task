import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/screens/widgets/maintenance_dialog_item_section.dart';

class EditMaintenanceDialog extends StatefulWidget {
  final MaintenanceCubit maintenanceCubit;
  final int index;
  final int maintenanceId;
  final String title;

  const EditMaintenanceDialog({
    super.key,
    required this.maintenanceCubit,
    required this.index,
    required this.maintenanceId,
    required this.title,
  });

  @override
  State<EditMaintenanceDialog> createState() => _EditMaintenanceDialogState();
}

class _EditMaintenanceDialogState extends State<EditMaintenanceDialog> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late ValueNotifier<AutovalidateMode> autovalidateMode;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.title);
    autovalidateMode = ValueNotifier<AutovalidateMode>(
      AutovalidateMode.disabled,
    );
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
                              onChanged: (value) {
                                context.read<MaintenanceCubit>().updateName(
                                  value!,
                                );
                              },
                            ),
                            const SizedBox(height: 20.0),
                            MaintenanceDialogItemSection(
                              autovalidateMode: autovalidateMode,
                              formKey: formKey,
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
  required int maintenanceId,
  required int index,
  required String title,
}) {
  showDialog(
    context: context,
    builder: (_) => EditMaintenanceDialog(
      maintenanceCubit: maintenanceCubit,
      maintenanceId: maintenanceId,
      index: index,
      title: title,
    ),
  );
}
