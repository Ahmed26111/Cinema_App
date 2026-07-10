import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/change_password_screen/change_password_state_management/change_password_cubit.dart';
import 'package:cinema_app/utils/components/change_password_successfully_snack_bar.dart';
import 'package:cinema_app/utils/components/confirm_password_not_same_with_new_password_snack_bar.dart';
import 'package:cinema_app/utils/components/default_gesture_detector_authentication_screen.dart';
import 'package:cinema_app/utils/components/default_user_authentication_screen.dart';
import 'package:cinema_app/utils/components/failed_to_change_password_snack_bar.dart';
import 'package:cinema_app/utils/components/old_password_not_valid_snack_bar.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/responsive size contants/responsive_size_constants.dart';
import '../../utils/components/default_authentication_title_and_subtitle.dart';
import '../../utils/components/default_pop_back_icon_button.dart';
import '../../utils/components/default_text_form_field.dart';
import '../../utils/components/default_user_authentication_filled_button.dart';
import '../../utils/shared/validation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState>_globalKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultGestureDetectorAuthenticationScreen(
      child: Scaffold(
        appBar: AppBar(
          leading: DefaultPopBackIconButton(),
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context , state) async{
              FocusScope.of(context).unfocus();

              // 2. Wait for the closing animation to finish (approx 300ms)
              await Future.delayed(const Duration(milliseconds: 300));

              if (!context.mounted) return; // Safety check for async gap

              if(state is OldPasswordNotValid){
                ScaffoldMessenger.of(context).showSnackBar(OldPasswordNotValidSnackBar.get(context));
              }
              else if(state is NewPasswordEqualConfirmPasswordFailed){
                ScaffoldMessenger.of(context).showSnackBar(ConfirmPasswordNotSameWithNewPasswordSnackBar.get(context));
              }
              else if(state is ChangePasswordFailed){
                ScaffoldMessenger.of(context).showSnackBar(FailedToChangePasswordSnackBar.get(context));
                context.pop();
              }
              else if(state is ChangePasswordSuccess){
                ScaffoldMessenger.of(context).showSnackBar(ChangePasswordSuccessfullySnackBar.get(context));
                HiveHandler.deleteActiveUser();
                context.go(RoutesConstants.loginScreen);
              }
            },
            builder: (context , state){
              return DefaultUserAuthenticationScreen(
                  globalKey: _globalKey,
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.05, vertical: 35),
                  children: [
                    ...defaultAuthenticationTitleAndSubtitle(title: "Change Password", subTitle: "Enter you new password", context: context),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.07,
                    ),
                    DefaultTextFormField(
                      controller: _oldPasswordController,
                      validator: null,
                      label: "Old Password",
                      hint: "********",
                      isPasswordField: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 15,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    DefaultTextFormField(
                      controller: _newPasswordController,
                      validator: _getPasswordValidator,
                      label: "New Password",
                      hint: "********",
                      isPasswordField: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 15,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    DefaultTextFormField(
                      controller: _confirmPasswordController,
                      validator: _getPasswordValidator,
                      label: "Confirm Password",
                      hint: "********",
                      isPasswordField: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 15,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.05,
                    ),
                    _getResetFilledButton(context),
                  ]
              );
            },
        ),
      ),
    );
  }

  Padding _getResetFilledButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: (){
          FocusScope.of(context).unfocus();
          if(_globalKey.currentState!.validate()){
            context.read<ChangePasswordCubit>().changeUserPassword(_oldPasswordController.text, _newPasswordController.text, _confirmPasswordController.text);
          }
        },
        text: "Reset",
        textStyle:Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  String? _getPasswordValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }

    if (text.contains(" ")) {
      return "Please do not add space to your password";
    }

    // 1. Length Check (Standard is usually 8-15)
    if (text.length < 8) {
      return "Password must be at least 8 characters long";
    }

    // 2. Check for at least one Uppercase letter
    if (!Validation.isContainUpperCase(text)) {
      return "Password must contain at least one uppercase letter";
    }

    // 3. Check for at least one Lowercase letter
    if (!Validation.isContainLowerCase(text)) {
      return "Password must contain at least one lowercase letter";
    }

    // 4. Check for at least one Digit
    if (!Validation.isContainDigit(text)) {
      return "Password must contain at least one number";
    }

    // 5. Check for at least one Special Character
    // (! @ # $ % ^ & * ( ) _ + - = [ ] { } ; : , . / < > ?)
    if (!Validation.isContainSpecialCharacter(text)) {
      return "Password must contain at least one special character (e.g. #?!@\$%^&*-)";
    }

    if(! Validation.isValidatePassword(text)){
      return "please , Enter your password contain english letter and digits and special character" ;
    }

    return null;
  }
}
