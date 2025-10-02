import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

Future<void> showToast({
  required BuildContext context,
  required String message,
  required ToastStates state,
}) async {
  switch (state) {
    case ToastStates.success:
      MotionToast.success(
        description: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ).show(context);
      break;

    case ToastStates.error:
      MotionToast.error(
        description: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ).show(context);
      break;

    case ToastStates.warning:
      MotionToast.warning(
        description: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ).show(context);
      break;
  }
}

enum ToastStates { success, error, warning }
