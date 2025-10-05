import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/assets_manager.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/tasks/cubit/tasks_cubit.dart';
import 'package:task/reports/tasks/cubit/tasks_state.dart';
import 'package:task/reports/tasks/data/add_task_request_model.dart';

class AddTaskDialog extends StatefulWidget {
  final TasksCubit cubit;

  const AddTaskDialog({super.key, required this.cubit});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final GlobalKey<FormState> formKey;

  late final TextEditingController dateController;

  late AutovalidateMode autovalidateMode;
  String name = "";
  String description = "";

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: const EdgeInsets.all(20.0),
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            Padding(
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
                        "اضافة مهمة",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),

                    const Text(
                      "يمكنك اضافة المهام التي تقوم بها عن طريق نموذج التعبئة التالي",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                      ),
                    ),

                    const SizedBox(height: 20.0),
                    Form(
                      key: formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "عنوان المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          CustomTextFormField(
                            hintText: "عنوان المهمة",
                            onSaved: (value) => name = value!,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "تاريخ المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),

                          const SizedBox(height: 5.0),
                          CustomTextFormField(
                            controller: dateController,
                            readOnly: true,
                            hintText: "تاريخ المهمة (تلقائي)",
                            onTap: () async {
                              await _formatData(context);
                            },
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "تفاصيل المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),

                          const SizedBox(height: 16.0),
                          CustomTextFormField(
                            hintText: "تفاصيل المهمة",
                            onSaved: (value) => description = value!,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10.0,
                      children: [
                        BlocProvider.value(
                          value: widget.cubit,
                          child: BlocConsumer<TasksCubit, TasksState>(
                            listenWhen: (prev, curr) =>
                                prev.addTaskState != curr.addTaskState,
                            listener: (context, state) {
                              if (state.addTaskState.isError) {
                                showToast(
                                  context: context,
                                  message: state.taskErrorMessage,
                                  state: ToastStates.error,
                                );
                              }
                              if (state.addTaskState.isSuccess) {
                                showToast(
                                  context: context,
                                  message:
                                      state.addAndEditTaskResponseModel.message,
                                  state: ToastStates.success,
                                );
                                Navigator.pop(context);
                              }
                            },
                            buildWhen: (prev, curr) =>
                                prev.addTaskState != curr.addTaskState,
                            builder: (context, state) {
                              return Expanded(
                                child: PrimaryButton(
                                  isLoading: state.addTaskState.isLoading,
                                  text: "حفظ التغيرات",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      final addTaskRequestModel =
                                          AddTaskRequestModel(
                                            name: name,
                                            description: description,
                                            date: dateController.text,
                                          );
                                      widget.cubit.addTask(
                                        addTaskRequestModel:
                                            addTaskRequestModel,
                                      );
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: PrimaryButton(
                            text: "الغاء",
                            onPressed: () => Navigator.pop(context),
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
            PositionedDirectional(
              top: 26.0,
              start: 26.0,
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

  Future<void> _formatData(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final finalDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second,
      );

      String formatDateTime(DateTime dt) {
        final year = dt.year.toString();
        final month = dt.month.toString().padLeft(2, '0');
        final day = dt.day.toString().padLeft(2, '0');
        final hour = dt.hour.toString().padLeft(2, '0');
        final minute = dt.minute.toString().padLeft(2, '0');
        final second = dt.second.toString().padLeft(2, '0');

        return "$year-$month-$day $hour:$minute:$second";
      }

      dateController.text = formatDateTime(finalDateTime);
    }
  }
}

void showAddTaskDialog(BuildContext context, {required TasksCubit cubit}) {
  showDialog(
    context: context,
    builder: (_) => AddTaskDialog(cubit: cubit),
  );
}
