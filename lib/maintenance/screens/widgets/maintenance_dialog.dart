import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/cubit/maintenance_state.dart';
import 'package:task/maintenance/data/add_maintenance_request_model.dart';
import 'package:task/maintenance/data/spare_parts_model.dart';
import 'package:task/maintenance/screens/widgets/maintenance_dialog_item_section.dart';
import 'package:task/maintenance/screens/widgets/maintenance_item_widgets.dart';
import 'package:task/shared/custom_text_form_field.dart';

class MaintenanceDialog extends StatefulWidget {
  final MaintenanceCubit maintenanceCubit;

  const MaintenanceDialog({super.key, required this.maintenanceCubit});

  @override
  State<MaintenanceDialog> createState() => _MaintenanceDialogState();
}

class _MaintenanceDialogState extends State<MaintenanceDialog> {
  final itemsNotifier = ValueNotifier<List<MaintenanceItemModel>>([
    MaintenanceItemModel(),
  ]);

  late final GlobalKey<FormState>formKey;
  late  ValueNotifier<AutovalidateMode> autovalidateMode ;
  @override
  void initState() {
   formKey = GlobalKey<FormState>();
    autovalidateMode = ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
    super.initState();
  }
@override
  void dispose() {
    itemsNotifier.dispose();
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                        const SizedBox(height: 20.0),
                        MaintenanceDialogItemSection(
                          itemsNotifier: itemsNotifier,
                          autovalidateMode: autovalidateMode,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
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

class MaintenanceItemModel {
  String? part;
  int? partId;
  String details;

  MaintenanceItemModel({this.part, this.partId, this.details = ""});
}

void showMaintenanceDialog(
  BuildContext context, {
  required MaintenanceCubit maintenanceCubit,
}) {
  showDialog(
    barrierColor: Colors.grey[500],
    context: context,
    builder: (_) => MaintenanceDialog(maintenanceCubit: maintenanceCubit),
  );
}
