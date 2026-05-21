import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.hint,
    this.textInputType,
    this.maxLength,
    this.isPasswordField = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool isPasswordField;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: ColorsManager.primarySoftColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: ColorsManager.primarySoftColor,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: ColorsManager.redColor, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: ColorsManager.redColor, width: 0.5),
        ),
        errorMaxLines: 2,
        suffixIconColor: (widget.isPasswordField)? ColorsManager.greyColor : null,
        suffixIcon: (widget.isPasswordField) ? IconButton(
          onPressed: () {
            setState(() {
              isSecure = ! isSecure;
            });
          },
          icon: Icon(
              (isSecure)
                  ?Icons.visibility_outlined
                  :Icons.visibility_off_outlined),
        ): null,
      ),
      maxLines: 1,
      minLines: 1,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      obscureText: (widget.isPasswordField) ? isSecure: false,
    );
  }
}
