import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/enums/request_status.dart';
import 'package:task/core/utils/show_toast.dart';
import 'package:task/core/widgets/primary_button.dart';
import 'package:task/shared/app_cubit/app_cubit.dart';
import 'package:task/shared/app_cubit/app_state.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "رسالة تأكيد",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: "إلغاء",
                        onPressed: () => Navigator.pop(context, false),
                        textColor: const Color(0xFF5B8C51),
                        backgroundColor: Colors.white,
                        borderColor: const Color(0xFF5B8C51),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BlocConsumer<AppCubit, AppState>(
                        listenWhen: (prev, curr) =>
                            prev.requestEditDeleteState !=
                            curr.requestEditDeleteState,
                        listener: (context, state) {
                          if (state.requestEditDeleteState.isSuccess) {
                            showToast(
                              context: context,
                              message: state.message,
                              state: ToastStates.success,
                            );
                            Navigator.pop(context);
                          }
                          if (state.requestEditDeleteState.isError) {
                            showToast(
                              context: context,
                              message: state.errorMessage,
                              state: ToastStates.error,
                            );
                          }
                        },
                        buildWhen: (prev, curr) =>
                            prev.requestEditDeleteState !=
                            curr.requestEditDeleteState,
                        builder: (context, state) {
                          return PrimaryButton(
                            isLoading: state.requestEditDeleteState.isLoading,
                            text: "تأكيد",
                            onPressed: () {
                              onConfirm();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 8,
            end: 8,
            child: IconButton(
              onPressed: () => Navigator.pop(context, false),
              icon: const Icon(Icons.close, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
