import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/data/add_maintenance_item_model.dart';
import 'package:task/maintenance/data/spare_parts_model.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';

class EditMaintenanceItemsField extends StatefulWidget {
  final AddMaintenanceItemModel item;
  final int index;
  final MaintenanceCubit cubit;

  const EditMaintenanceItemsField({
    super.key,
    required this.item,
    required this.index, required this.cubit,
  });

  @override
  State<EditMaintenanceItemsField> createState() =>
      _EditMaintenanceItemsFieldState();
}

class _EditMaintenanceItemsFieldState extends State<EditMaintenanceItemsField> {
  late final TextEditingController descriptionController;
  late String selectedPartName;

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(
      text: widget.item.description,
    );
    selectedPartName = widget.cubit.state.spareParts
        .firstWhere((p) => p.id == widget.item.carSpartId)
        .name;
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
        DropdownButtonFormField<String>(
          initialValue: selectedPartName,
          icon: const Icon(
            CupertinoIcons.chevron_down,
            size: 16.0,
            color: Colors.black54,
          ),
          decoration: _dropdownDecoration,
          dropdownColor: Colors.white,
          items: context
              .select<MaintenanceCubit, List<SparePartsModel>>(
                (cubit) => cubit.state.spareParts,
              )
              .map(
                (part) => DropdownMenuItem<String>(
                  value: part.name,
                  child: Text(part.name),
                ),
              )
              .toList(),
          validator: (val) =>
              (val == null || val.isEmpty) ? "الرجاء اختيار قطعة" : null,
          onChanged: (value) {
            setState(() => selectedPartName = value!);
            final part = cubit.state.spareParts.firstWhere(
              (p) => p.name == value,
            );
            final updated = widget.item.copyWith(carSpartId: part.id);
            cubit.updateMaintenanceItems(widget.index, updated);
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
          onChanged: (val) {
            final updated = widget.item.copyWith(description: val!);
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
              child: const Text("حذف", style: TextStyle(color: Colors.red)),
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
