import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/custom_dialog.dart';
import 'package:task/custom_text_form_field.dart';

void showMaintenanceDialog(BuildContext context) {
  final itemsNotifier = ValueNotifier<List<MaintenanceItem>>([
    MaintenanceItem(),
  ]);

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  showDialog(
    barrierColor: Colors.grey[500],
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return CustomDialog(
            title: "اضافة صيانة",
            subTitle:
                "يمكنك اضافة القطع التي قومت بصيانتها عن طريق نموذج التعبئة التالي",
            body: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    "عنوان",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const CustomTextFormField(hintText: "عنوان"),
                  const SizedBox(height: 20.0),
                  ValueListenableBuilder<List<MaintenanceItem>>(
                    valueListenable: itemsNotifier,
                    builder: (context, items, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...items.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "القطع",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                DropdownButtonFormField<String>(
                                  initialValue: item.part,
                                  icon: const SizedBox.shrink(),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE8ECF4),
                                        width: 1.05,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.indigo,
                                        width: 1.05,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.05,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    hintText: "اختر قطعة",
                                    prefixIcon: Icon(
                                      CupertinoIcons.chevron_down,
                                      color: Colors.black54,
                                      size: 18.0,
                                    ),
                                  ),
                                  dropdownColor: Colors.white,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "كاوتش",
                                      child: Text("كاوتش"),
                                    ),
                                    DropdownMenuItem(
                                      value: "فرامل",
                                      child: Text("فرامل"),
                                    ),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "الرجاء اختيار قطعة";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    item.part = value;
                                    itemsNotifier.value = List.from(items);
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  "تفاصيل",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                CustomTextFormField(
                                  maxLines: 3,
                                  hintText: "تفاصيل",
                                  onChanged: (val) {
                                    item.details = val!;
                                  },
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
                                      child: const Text(
                                        "حذف",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 18.0),
                              ],
                            );
                          }),
                          TextButton(
                            onPressed: () {
                              items.add(MaintenanceItem());
                              itemsNotifier.value = List.from(items);
                            },
                            child: const Text(
                              "+ اضافة عنصر جديد",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            save: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                for (var item in itemsNotifier.value) {
                  debugPrint("${item.part}, ${item.details}");
                }
              } else {
                setStateDialog(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
            finish: () {},
          );
        },
      );
    },
  );
}

class MaintenanceItem {
  String? part;
  String details;

  MaintenanceItem({this.part, this.details = ""});
}
