import 'package:flutter/material.dart';
import 'package:task/tasks/data/task_model.dart';
import 'custom_dialog.dart';

class CustomDismissible extends StatelessWidget {
  final Key keyValue;
  final Widget child;
  final String editMessage;
  final VoidCallback onEdit;
  final String deleteMessage;
  final VoidCallback onDelete;
  final bool isLoading;
  final bool canEdit;
  final bool canDelete;

  const CustomDismissible({
    super.key,
    required this.keyValue,
    required this.child,
    required this.editMessage,
    required this.onEdit,
    required this.deleteMessage,
    this.isLoading = false,
    required this.onDelete,
    required this.canEdit,
    required this.canDelete,
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
                isLoading: isLoading,
                message: editMessage,
                onConfirm: () {
                  onEdit();
                },
              ),
            );
            return confirm;
          }
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => CustomDialog(
              isLoading: isLoading,
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
