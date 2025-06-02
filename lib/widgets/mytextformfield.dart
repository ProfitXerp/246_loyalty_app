import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final Icon prefix;
  final String hinttext;
  final String? text;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final VoidCallback? onTap;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextFormField({
    super.key,
    required this.prefix,
    required this.hinttext,
    this.text,
    required this.textInputAction,
    required this.obscureText,
    required this.controller,
    required this.validator,
    required this.textInputType,
    this.onTap,
    this.suffix,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: textInputType,
        onTap: onTap,
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: prefix,
          hintText: hinttext,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(width: 1),
          ),
        ),
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}
