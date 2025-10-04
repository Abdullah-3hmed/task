import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/tasks/cubit/tasks_cubit.dart';
import 'package:task/tasks/cubit/tasks_state.dart';
import 'package:task/tasks/data/task_model.dart';
import 'custom_dialog.dart';

class CustomDismissible extends StatelessWidget {
  final Key keyValue;
  final Widget child;
  final String editMessage;
  final VoidCallback onEdit;
  final VoidCallback onRequestEdit;
  final String deleteMessage;
  final VoidCallback onDelete;
  final bool canEdit;
  final bool canDelete;

  const CustomDismissible({
    super.key,
    required this.keyValue,
    required this.child,
    required this.editMessage,
    required this.onEdit,
    required this.deleteMessage,
    required this.onDelete,
    required this.canEdit,
    required this.canDelete,
    required this.onRequestEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: keyValue,
      background: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          if (canEdit) {
            onEdit();
            return false;
          } else {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => CustomDialog(
                message: editMessage,
                onConfirm: () {
                  onRequestEdit();
                },
              ),
            );
            return confirm;
          }
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => CustomDialog(
              message: deleteMessage,
              onConfirm: () {
                onDelete();
              },
            ),
          );
          return confirm;
        }
        return false;
      },
      child: child,
    );
  }


}
