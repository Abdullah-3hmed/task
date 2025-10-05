import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/cubit/maintenance_state.dart';
import 'package:task/reports/maintenance/data/add_maintenance_item_model.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/data/spare_parts_model.dart';

class EditMaintenanceItemFields extends StatefulWidget {
  const EditMaintenanceItemFields({
    super.key,
    required this.item,
    required this.index,
  });

  final AddMaintenanceItemModel item;
  final int index;

  @override
  State<EditMaintenanceItemFields> createState() =>
      _EditMaintenanceItemFieldsState();
}

class _EditMaintenanceItemFieldsState extends State<EditMaintenanceItemFields> {
  late final TextEditingController descriptionController;

  @override
  void initState() {
    descriptionController = TextEditingController(
      text: widget.item.description,
    );
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MaintenanceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label("القطع"),
        const SizedBox(height: 5.0),
        BlocBuilder<MaintenanceCubit, MaintenanceState>(
          buildWhen: (prev, curr) => prev.spareParts != curr.spareParts,
          builder: (context, state) {
            final availableParts = cubit.getAvailableSpareParts(
              currentSelectedId: widget.item.carSpartId,
            );

            return DropdownButtonFormField<int>(
              key: ValueKey(
                'dropdown_${widget.index}_${widget.item.carSpartId}',
              ),
              initialValue: widget.item.carSpartId == 0
                  ? null
                  : widget.item.carSpartId,
              icon: const SizedBox.shrink(),
              decoration: _dropdownDecoration.copyWith(
                prefixIcon: const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16.0,
                  color: Colors.black54,
                ),
              ),
              dropdownColor: Colors.white,
              items: availableParts.map((part) {
                return DropdownMenuItem<int>(
                  value: part.id,
                  child: Text(part.name, textAlign: TextAlign.right),
                );
              }).toList(),
              validator: (val) =>
                  (val == null || val == 0) ? "الرجاء اختيار قطعة" : null,
              onChanged: (value) {
                final updated = widget.item.copyWith(carSpartId: value);
                cubit.updateMaintenanceItems(widget.index, updated);
              },
            );
          },
        ),

        const SizedBox(height: 20.0),
        const _Label("تفاصيل"),
        const SizedBox(height: 16.0),
        CustomTextFormField(
          controller: descriptionController,
          maxLines: 3,
          hintText: "تفاصيل",
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            final updated = widget.item.copyWith(
              description: descriptionController.text,
            );
            cubit.updateMaintenanceItems(widget.index, updated);
          },
        ),
        const SizedBox(height: 12.0),
        if (context.read<MaintenanceCubit>().state.maintenanceItems.length >
                1 &&
            widget.index > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => cubit.removeMaintenanceItem(widget.index),
              child: const Text(
                "حذف",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        const SizedBox(height: 18.0),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
    );
  }
}

const _dropdownDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE8ECF4), width: 1.05),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigo, width: 1.05),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.05),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  hintText: "اختر قطعة",
);
