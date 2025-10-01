import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/app_constants.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key});

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
    return Stack(
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
                      const Text(
                        "مهمة 1",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: AppConstants.fontCairo,
                          fontSize: 14.0,
                          color: Color(0xFF303A42),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "25/9/2025",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.0,
                          color: Colors.black.withValues(alpha: 37),
                        ),
                      ),
                      const Text(
                        "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص زيادة عدد الحروف التى يولدها التطبيق.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,

                          fontSize: 12.0,
                          color: Color(0xFF303A42),
                        ),
                      ),

                      ValueListenableBuilder<bool>(
                        valueListenable: _isExpanded,
                        builder: (context, isExpanded, _) {
                          if (!isExpanded) return const SizedBox.shrink();
                          return Row(
                            spacing: 10.0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                height: 40.0,
                                color: const Color(0xFF008000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "بدء",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: AppConstants.fontCairo,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                height: 40.0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color(0xFF5B8C51),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "انهاء",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF5B8C51),
                                    fontFamily: AppConstants.fontCairo,
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
    );
  }
}
