import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    this.borderSideColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIconName,
    this.suffixIconName,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    required this.controller,
    this.prefixIconColor,
    this.suffixIconColor,
    this.maxLines=1,
    this.onChanged
  });

  final Color? borderSideColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIconName;
  final Widget? suffixIconName;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final TextEditingController? controller;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final int maxLines;
  void Function(String)? onChanged ;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      cursorColor: AppColors.primaryLight,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      obscuringCharacter: widget.obscuringCharacter,
      cursorErrorColor: AppColors.redColor,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        enabledBorder: bulitOutLineInputBorder(
          borderSideColor: widget.borderSideColor ?? Theme.of(context).dividerColor,
        ),
        focusedBorder: bulitOutLineInputBorder(
          borderSideColor:widget.borderSideColor ?? Theme.of(context).dividerColor,
        ),
        errorBorder: bulitOutLineInputBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: bulitOutLineInputBorder(borderSideColor: AppColors.redColor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.bodyMedium,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? Theme.of(context).textTheme.bodyMedium,
        prefixIcon: widget.prefixIconName,
        prefixIconColor: Theme.of(context).highlightColor,
        suffixIcon: widget.suffixIconName,
        suffixIconColor: Theme.of(context).highlightColor,
      ),
    );
  }

  OutlineInputBorder bulitOutLineInputBorder({required Color borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderSideColor, width: 1),
    );
  }
}
