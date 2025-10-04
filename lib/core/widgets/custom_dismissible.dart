import 'package:flutter/material.dart';
import 'custom_dialog.dart';

class CustomDismissible extends StatelessWidget {
  final Key keyValue;
  final Widget child;
  final String editMessage;
  final Future<void> Function() onEdit;
  final String deleteMessage;
  final Future<void> Function() onDelete;
  final bool isLoading;

  const CustomDismissible({
    super.key,
    required this.keyValue,
    required this.child,
    required this.editMessage,
    required this.onEdit,
    required this.deleteMessage,
    this.isLoading = false,
    required this.onDelete,
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
          final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => CustomDialog(
              isLoading: isLoading,
              message: editMessage,
              onConfirm: () async {
                await onEdit();
              },
            ),
          );
          if (confirm == true) {
            await onEdit();
            return true;
          }
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => CustomDialog(
              isLoading: isLoading,
              message: deleteMessage,
              onConfirm: () async {
                await onDelete();
              },
            ),
          );
          if (confirm == true) {
            await onDelete();
            return true;
          }
        }
        return false;
      },
      child: child,
    );
  }
}
