import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.maxLines,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.suffixIcon,
    this.type,
  });

  final String hintText;
  final int? maxLines;
  final Function(String? value)? onSaved;
  final Function(String? value)? onChanged;
  final Function(String? value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE8ECF4), width: 1.05),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.indigo, width: 1.05),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.05),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.05),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "الرجاء إدخال $hintText";
        }
        return null;
      },
    );
  }
}
