import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/maintenance/data/maintenance_model.dart';

class MaintenanceListItem extends StatefulWidget {
  const MaintenanceListItem({super.key, required this.maintenanceModel});

  final MaintenanceModel maintenanceModel;

  @override
  State<MaintenanceListItem> createState() => _MaintenanceListItemState();
}

class _MaintenanceListItemState extends State<MaintenanceListItem> {
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
                    "assets/images/settings.svg",
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
                        widget.maintenanceModel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.maintenanceModel.date,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                          color: Colors.black.withValues(alpha: 37),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isExpanded,
                        builder: (context, isExpanded, _) {
                          return AnimatedSize(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 300),
                            child: isExpanded
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "تم صيانة الاتي : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 18.0),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                start: 18.0,
                                              ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "• ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget
                                                      .maintenanceModel
                                                      .items[index]
                                                      .description,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        itemCount: widget
                                            .maintenanceModel
                                            .items
                                            .length,
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
    );
  }
}
