import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/utils/app_constants.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_dismissible.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/tasks/data/task_model.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDismissible(
      keyValue: ValueKey(widget.task.id),
      deleteMessage:
          "لحذف هذه المهمة تحتاج إلى إذن من إدارة التطيق . هل ترغب فى ذلك ؟",
      editMessage:
          "للتعديل على هذه المهمة تحتاج إلى إذن من إدارة التطبيق . هل ترغب فى ذلك؟",
      onDelete: (){
        print("deleted");
     return Future.value("deleted");

      },
      onEdit: (){
        print("edited");
        return Future.value("edited");
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Card(
            shadowColor: Colors.black,
            elevation: 2.0,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(12.0),
                bottomStart: Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26.0,
                    backgroundColor: const Color(0xFFF4F5F6),
                    child: SvgPicture.asset(
                      "assets/images/crown.svg",
                      fit: BoxFit.cover,
                      width: 22.0,
                      height: 26.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstants.fontCairo,
                            fontSize: 14.0,
                            color: Color(0xFF303A42),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.task.startDateTime.split(" ").first,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0,
                            color: Colors.black.withValues(alpha: 37),
                          ),
                        ),
                        Text(
                          widget.task.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: Color(0xFF303A42),
                          ),
                        ),

                        ValueListenableBuilder<bool>(
                          valueListenable: _isExpanded,
                          builder: (context, isExpanded, _) {
                            return AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              child: isExpanded
                                  ? Row(
                                      spacing: 10.0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        PrimaryButton(
                                          text: "بدء",
                                          onPressed: () {},
                                          height: 40.0,
                                          backgroundColor: const Color(
                                            0xFF008000,
                                          ),
                                        ),
                                        PrimaryButton(
                                          text: "انهاء",
                                          onPressed: () {},
                                          textColor: const Color(0xFF5B8C51),
                                          height: 40,
                                          borderColor: const Color(0xFF5B8C51),
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isExpanded,
            builder: (context, isExpanded, _) {
              return IconButton(
                onPressed: () => _isExpanded.value = !isExpanded,
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
