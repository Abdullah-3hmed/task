import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF292929),
    this.borderColor = Colors.transparent,
    this.height = 50.0,
    this.fontSize = 14.0,
    this.textColor = const Color(0xFFFFFEFC),
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final double height;
  final double fontSize;
  final Color textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: borderColor, width: 1.2),
      ),
      onPressed: onPressed,
      child: isLoading == true
          ?  const SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
              duration: Duration(milliseconds: 900),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
    );
  }
}
