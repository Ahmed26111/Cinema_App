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

  // 1. Create the FocusNode
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // 2. Always dispose focus nodes to avoid memory leaks
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: ColorsManager.primaryBlueAccentColor,
        selectionColor: ColorsManager.primaryBlueAccentColorLessOpacity,
        selectionHandleColor: ColorsManager.primaryBlueAccentColor,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode, // 3. Assign the FocusNode
        validator: widget.validator,
        style: Theme.of(context).textTheme.headlineLarge,
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
          // 1. Control the Error Message Font
          errorStyle: Theme.of(context).textTheme.headlineSmall,
          // 2. Control the MaxLength (Counter) Font
          counterStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: ColorsManager.greyColor,
            fontSize: 10,
          ),
        ),
        maxLines: 1,
        minLines: 1,
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        obscureText: (widget.isPasswordField) ? isSecure: false,
        cursorErrorColor: ColorsManager.redColor,
        autofocus: false,
        onTap: () async{
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          // --- Magic Code to Delay Keyboard ---
          // Check if it's not already focused to avoid double-delaying
          if (!_focusNode.hasFocus) {
            // Temporarily take focus away to stop the keyboard from jumping up
            _focusNode.unfocus();

            // Wait for 500ms (or any time you want)
            await Future.delayed(const Duration(milliseconds: 200));

            // Now show the keyboard
            _focusNode.requestFocus();
          }
        },
      ),
    );
  }
}
