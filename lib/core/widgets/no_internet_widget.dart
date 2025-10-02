import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.errorMessage,
  });

  final void Function() onPressed;
  final bool isLoading;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          const Icon(
            Icons.wifi_off,
            size: 100.0,
            color:  Color(0xFF5B8C51),
          ),
          const SizedBox(height: 24.0),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 4.0),
          Text(
            "Please make sure that you are \n connected to the wifi",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const Spacer(),
          MaterialButton(
            height: 50,
            minWidth: 200,
            color:  const Color(0xFF5B8C51),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? const SpinKitCircle(
              color: Colors.white,
              size: 24.0,
            )
                : const Text(
              "Try Again",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
