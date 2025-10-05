import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/enums/request_edit_delete_enum.dart';
import 'package:task/core/widgets/custom_dismissible.dart';
import 'package:task/reports/maintenance/cubit/maintenance_cubit.dart';
import 'package:task/reports/maintenance/data/maintenance_model.dart';
import 'package:task/reports/maintenance/screens/widgets/edit_maintenance_dialog.dart';
import 'package:task/reports/maintenance/screens/widgets/maintenance_dialog.dart';
import 'package:task/shared/report_cubit/report_cubit.dart';

class MaintenanceListItem extends StatefulWidget {
  const MaintenanceListItem({
    super.key,
    required this.maintenanceModel,
    required this.index,
  });

  final MaintenanceModel maintenanceModel;
  final int index;

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
    return CustomDismissible(
      key: ValueKey(widget.maintenanceModel.id),
      keyValue: ValueKey(widget.maintenanceModel.id),
      canDelete: widget.maintenanceModel.canDelete,
      canEdit: widget.maintenanceModel.canEdit,
      deleteMessage:
          "لحذف هذا العنصر تحتاج إلى إذن من إدارة التطبيق . هل ترغب فى ذلك ؟",
      editMessage:
          "لتعديل هذا العنصر تحتاج إلى إذن من إدارة التطبيق . هل ترغب فى ذلك ؟ ",
      onEdit: () {
        showEditMaintenanceDialog(
          context,
          maintenanceCubit: context.read<MaintenanceCubit>(),
          maintenanceModel: widget.maintenanceModel,
          index: widget.index,
        );
      },
      onDelete: () async {
        await context.read<MaintenanceCubit>().deleteMaintenance(
          id: widget.maintenanceModel.id,
          index: widget.index,
        );
      },
      onRequestDelete: () async {
        await context.read<ReportCubit>().requestEditDeleteMaintenance(
          id: widget.maintenanceModel.id,
          requestEditDelete: RequestEditDeleteEnum.delete,
        );
      },
      onRequestEdit: () async {
        context.read<ReportCubit>().requestEditDeleteMaintenance(
          id: widget.maintenanceModel.id,
          requestEditDelete: RequestEditDeleteEnum.edit,
        );
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
      ),
    );
  }
}
