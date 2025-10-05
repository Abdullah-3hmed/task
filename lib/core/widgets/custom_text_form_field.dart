import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.inputFormatters,
  });

  final String hintText;
  final int? maxLines;
  final Function(String? value)? onSaved;
  final Function(String? value)? onChanged;
  final Function(String? value)? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final TextInputType? type;
  final TextEditingController? controller;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      controller: controller,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        alignLabelWithHint: true,
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
