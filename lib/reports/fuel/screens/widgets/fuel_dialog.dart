import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/assets_manager.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/reports/fuel/cubit/fuel_cubit.dart';
import 'package:task/reports/fuel/cubit/fuel_state.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';

class FuelDialog extends StatefulWidget {
  const FuelDialog({super.key, required this.fuelCubit});

  final FuelCubit fuelCubit;

  @override
  State<FuelDialog> createState() => _FuelDialogState();
}

class _FuelDialogState extends State<FuelDialog> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  double numberOfLiters = 0.0;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.fuelCubit,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "اضافة تعبئة",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        "يمكنك الحجم الذي قمت بتعبئته عن طريق نموذج التعبئة التالي",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            const Text(
                              "الحجم",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              hintText: "الحجم",
                              textInputAction: TextInputAction.done,
                              type: const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$'),
                                ),
                              ],
                              onSaved: (value) {
                                numberOfLiters = double.parse(value!);
                              },
                              suffixIcon: const SizedBox(
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "لتر",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        spacing: 10.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: BlocConsumer<FuelCubit, FuelState>(
                              listenWhen: (prev, curr) =>
                                  prev.addFuelState != curr.addFuelState,
                              listener: (context, state) {
                                if (state.addFuelState.isSuccess) {
                                  showToast(
                                    context: context,
                                    message: "تم إرسال البيانات بنجاح",
                                    state: ToastStates.success,
                                  );
                                  Navigator.pop(context);
                                }
                                if (state.addFuelState.isError) {
                                  showToast(
                                    context: context,
                                    state: ToastStates.error,
                                    message: state.fuelErrorMessage,
                                  );
                                }
                              },
                              buildWhen: (prev, curr) =>
                                  prev.addFuelState != curr.addFuelState,
                              builder: (context, state) {
                                return PrimaryButton(
                                  isLoading: state.addFuelState.isLoading,
                                  text: "حفظ التغيرات",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      context.read<FuelCubit>().addFuel(
                                        numberOfLiters: numberOfLiters,
                                      );
                                    } else {
                                      setState(() {
                                        _autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: PrimaryButton(
                              text: "الغاء",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              borderColor: AssetsManager.primaryColor,
                              backgroundColor: Colors.white,
                              textColor: AssetsManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              top: 26.0,
              end: 26.0,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
