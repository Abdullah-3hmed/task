import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/fuel/screens/widgets/fuel_list_item.dart';
import 'package:task/shared/custom_dialog.dart';
import 'package:task/shared/custom_text_form_field.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "تقرير تعبئة الوقود",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Color(0xFF303A42),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        final GlobalKey<FormState> formKey =
                            GlobalKey<FormState>();
                        AutovalidateMode autovalidateMode =
                            AutovalidateMode.disabled;

                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return CustomDialog(
                              onSave: () {},
                              title: "اضافة تعبئة",
                              subTitle:
                                  "يمكنك الحجم الذي قمت بتعبئته عن طريق نموذج التعبئة التالي",
                              body: Form(
                                key: formKey,
                                autovalidateMode: autovalidateMode,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20.0),
                                    Text(
                                      "الحجم",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    CustomTextFormField(
                                      hintText: "الحجم",
                                      textInputAction: TextInputAction.done,
                                      type: TextInputType.number,
                                      suffixIcon: SizedBox(
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "لتر",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12.0,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFF5B8C51),
                            size: 20.0,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Text(
                          "اضافة جديد",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0,
                            color: Color(0xFF5B8C51),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const FuelListItem(),
                  separatorBuilder: (_, _) => const SizedBox(height: 24.0),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
