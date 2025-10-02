import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/maintenance/data/spare_parts_model.dart';
import 'package:task/maintenance/screens/widgets/maintenance_dialog.dart';
import 'package:task/shared/custom_text_form_field.dart';

class ItemFields extends StatelessWidget {
  final MaintenanceItemModel item;
  final List<MaintenanceItemModel> items;
  final int index;
  final ValueNotifier<List<MaintenanceItemModel>> itemsNotifier;

  const ItemFields({
    super.key,
    required this.item,
    required this.items,
    required this.index,
    required this.itemsNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label("القطع"),
        const SizedBox(height: 5.0),
        DropdownButtonFormField<String>(
          initialValue: item.part,
          icon: const Icon(
            CupertinoIcons.chevron_down,
            size: 18.0,
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
            final part = context
                .read<MaintenanceCubit>()
                .state
                .spareParts
                .firstWhere((p) => p.name == value);
            item.part = value;
            item.partId = part.id;
            itemsNotifier.value = List.from(items);
          },
        ),
        const SizedBox(height: 20.0),
        const _Label("تفاصيل"),
        const SizedBox(height: 5.0),
        CustomTextFormField(
          maxLines: 3,
          hintText: "تفاصيل",
          textInputAction: TextInputAction.done,
          onChanged: (val) => item.details = val ?? "",
        ),
        const SizedBox(height: 12.0),
        if (items.length > 1 && index > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                items.removeAt(index);
                itemsNotifier.value = List.from(items);
              },
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