import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_dialog_body.dart';

class MaintenanceDialog extends StatefulWidget {
  final MaintenanceCubit maintenanceCubit;

  const MaintenanceDialog({super.key, required this.maintenanceCubit});

  @override
  State<MaintenanceDialog> createState() => _MaintenanceDialogState();
}

class _MaintenanceDialogState extends State<MaintenanceDialog> {
  late final GlobalKey<FormState> formKey;
  late ValueNotifier<AutovalidateMode> autovalidateMode;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    autovalidateMode = ValueNotifier<AutovalidateMode>(
      AutovalidateMode.disabled,
    );
    widget.maintenanceCubit.initForAdd();
    super.initState();
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
                      child: CustomScrollView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20.0),
                                const Center(
                                  child: Text(
                                    "اضافة صيانة",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                const Text(
                                  "يمكنك اضافة القطع التي قومت بصيانتها عن طريق نموذج التعبئة التالي",
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
                                  hintText: "عنوان",
                                  onSaved: (value) {
                                    context.read<MaintenanceCubit>().updateName(
                                      value!,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                MaintenanceDialogBody(
                                  autovalidateMode: autovalidateMode,
                                  formKey: formKey,
                                ),
                              ],
                            ),
                          ),
                        ],
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

void showMaintenanceDialog(
  BuildContext context, {
  required MaintenanceCubit maintenanceCubit,
}) {
  showDialog(
    context: context,
    builder: (_) => MaintenanceDialog(maintenanceCubit: maintenanceCubit),
  );
}
