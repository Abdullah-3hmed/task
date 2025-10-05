import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/reports/tasks/cubit/tasks_cubit.dart';
import 'package:task/reports/tasks/cubit/tasks_state.dart';
import 'package:task/reports/tasks/data/edit_task_request_model.dart';
import 'package:task/reports/tasks/data/task_model.dart';

class EditTaskDialog extends StatefulWidget {
  final TasksCubit cubit;
  final TaskModel task;

  const EditTaskDialog({super.key, required this.cubit, required this.task});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController dateController;

  late AutovalidateMode autovalidateMode;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    nameController = TextEditingController(text: widget.task.name);
    descriptionController = TextEditingController(
      text: widget.task.description,
    );
    dateController = TextEditingController(text: widget.task.startDateTime);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                      "تعديل المهمة",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "يمكنك تعديل بيانات المهمة عبر النموذج التالي",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "عنوان المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        CustomTextFormField(
                          controller: nameController,
                          hintText: "عنوان المهمة",
                        ),
                        const SizedBox(height: 20.0),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "تاريخ المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        CustomTextFormField(
                          controller: dateController,
                          readOnly: true,
                          hintText: "تاريخ المهمة",
                          onTap: () async {
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

                              dateController.text = DateFormat(
                                "yyyy-MM-dd HH:mm:ss",
                              ).format(finalDateTime);
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "تفاصيل المهمة",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          controller: descriptionController,
                          hintText: "تفاصيل المهمة",
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
                      Expanded(
                        child: PrimaryButton(
                          text: "الغاء",
                          onPressed: () => Navigator.pop(context),
                          borderColor: const Color(0xFF5B8C51),
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF5B8C51),
                        ),
                      ),
                      BlocProvider.value(
                        value: widget.cubit,
                        child: BlocConsumer<TasksCubit, TasksState>(
                          listenWhen: (prev, curr) =>
                              prev.editTaskState != curr.editTaskState,
                          listener: (context, state) {
                            if (state.editTaskState.isError) {
                              showToast(
                                context: context,
                                message: state.taskErrorMessage,
                                state: ToastStates.error,
                              );
                            }
                            if (state.editTaskState.isSuccess) {
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
                              prev.editTaskState != curr.editTaskState,
                          builder: (context, state) {
                            return Expanded(
                              child: PrimaryButton(
                                isLoading: state.editTaskState.isLoading,
                                text: "حفظ التغييرات",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    EditTaskRequestModel editTaskRequestModel =
                                        EditTaskRequestModel(
                                          id: widget.task.id,
                                          name: nameController.text,
                                          description:
                                              descriptionController.text,
                                          date: dateController.text,
                                        );
                                    widget.cubit.editTask(
                                      editTaskRequestModel:
                                          editTaskRequestModel,
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
                    ],
                  ),
                ],
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
    );
  }
}

void showEditTaskDialog(
  BuildContext context, {
  required TasksCubit cubit,
  required TaskModel task,
}) {
  showDialog(
    context: context,
    builder: (_) => EditTaskDialog(cubit: cubit, task: task),
  );
}
