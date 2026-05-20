import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({super.key, required this.controller,required this.validator, required this.label, required this.hint,  this.textInputType,  this.maxLength});

  final TextEditingController controller;
  final String? Function(String ?)? validator;
  final String label;
  final String hint;
  final TextInputType ? textInputType;
  final int ? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: ColorsManager.primarySoftColor ,
                width: 0.5
            )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: ColorsManager.primarySoftColor ,
            width: 0.5
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: ColorsManager.redColor ,
            width: 0.5
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: ColorsManager.redColor ,
            width: 0.5
          )
        ),
        errorMaxLines: 2
      ),
      maxLines: 1,
      minLines: 1,
      maxLength: maxLength,
      keyboardType: textInputType,
    );
  }
}
