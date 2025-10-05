import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/reports/fuel/cubit/fuel_cubit.dart';
import 'package:task/reports/fuel/cubit/fuel_state.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';

class EditFuelDialog extends StatefulWidget {
  const EditFuelDialog({
    super.key,
    required this.fuelCubit,
    required this.fuelId,
    required this.initialLiters,
  });

  final FuelCubit fuelCubit;
  final int fuelId;
  final double initialLiters;

  @override
  State<EditFuelDialog> createState() => _EditFuelDialogState();
}

class _EditFuelDialogState extends State<EditFuelDialog> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  late final TextEditingController fuelController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    fuelController = TextEditingController(
      text: widget.initialLiters.toString(),
    );
    super.initState();
  }

  @override
  void dispose() {
    fuelController.dispose();
    super.dispose();
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
                          "تعديل التعبئة",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الحجم",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              controller: fuelController,
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
                                  prev.editFuelState != curr.editFuelState,
                              listener: (context, state) {
                                if (state.editFuelState.isSuccess) {
                                  showToast(
                                    context: context,
                                    message: "تم تعديل البيانات بنجاح",
                                    state: ToastStates.success,
                                  );
                                  Navigator.pop(context);
                                }
                                if (state.editFuelState.isError) {
                                  showToast(
                                    context: context,
                                    state: ToastStates.error,
                                    message: state.fuelErrorMessage,
                                  );
                                }
                              },
                              buildWhen: (prev, curr) =>
                                  prev.editFuelState != curr.editFuelState,
                              builder: (context, state) {
                                return PrimaryButton(
                                  isLoading: state.editFuelState.isLoading,
                                  text: "حفظ التغيرات",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<FuelCubit>().editFuel(
                                        fuelId: widget.fuelId,
                                        numberOfLiters: double.parse(
                                          fuelController.text,
                                        ),
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
                              borderColor: const Color(0xFF5B8C51),
                              backgroundColor: Colors.white,
                              textColor: const Color(0xFF5B8C51),
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
