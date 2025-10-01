import 'package:flutter/material.dart';
import 'package:task/custom_dialog.dart';
import 'package:task/custom_text_form_field.dart';

void showAddTaskDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setStateDialog) {
        return CustomDialog(
          title: "اضافة مهمة",
          subTitle: "يمكنك اضافة المهام التي تقوم بها عن طريق نموذج التعبئة التالي",
          body: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text("عنوان المهمة"),
                CustomTextFormField(hintText: "عنوان المهمة"),
                SizedBox(height: 20.0),
                Text("تاريخ المهمة"),
                CustomTextFormField(hintText: "تاريخ المهمة (تلقائي)"),
                SizedBox(height: 20.0),
                Text("تفاصيل المهمة"),
                CustomTextFormField(hintText: "تفاصيل المهمة", maxLines: 5),
              ],
            ),
          ),
          save: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
            } else {
              setStateDialog(() {
                autovalidateMode = AutovalidateMode.always;
              });
            }
          },
          finish: () {},
        );
      },
    ),
  );
}
