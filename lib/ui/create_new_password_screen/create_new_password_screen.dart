import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/signup_screen/validation_user_cubit.dart';
import 'package:cinema_app/utils/components/confirm_password_not_same_with_new_password_snack_bar.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final GlobalKey<FormState>_globalKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: BlocConsumer<ValidationUserCubit, ValidationUserState>(
            listener: (context, state) {
              FocusScope.of(context).unfocus();
              if(state is ValidationUserIsNewPasswordEqualConfirmPasswordFailed){
                ScaffoldMessenger.of(context).showSnackBar(ConfirmPasswordNotSameWithNewPasswordSnackBar.get(context));
              }
              else if(state is ValidationUserIsUpdatePasswordFailed){
                ScaffoldMessenger.of(context).showSnackBar(ConfirmPasswordNotSameWithNewPasswordSnackBar.get(context));
              }
              else if(state is ValidationUserIsUpdatePasswordSuccess){
                context.pop();
                context.pop();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _globalKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18, vertical: 35),
                      child: Column(
                        children: [
                          ...defaultAuthenticationTitleAndSubtitle(
                              title: "Create New Password",
                              subTitle: "Enter you new password",
                              context: context),
                          SizedBox(
                            height: ResponsiveSizeConstants.heightScreen(
                                context) * 0.07,
                          ),
                          DefaultTextFormField(
                            controller: _newPasswordController,
                            validator: _getPasswordValidator,
                            label: "New Password",
                            hint: "********",
                            isPasswordField: true,
                            maxLength: 15,
                          ),
                          SizedBox(
                            height: ResponsiveSizeConstants.heightScreen(
                                context) * 0.02,
                          ),
                          DefaultTextFormField(
                            controller: _confirmPasswordController,
                            validator: _getPasswordValidator,
                            label: "Confirm Password",
                            hint: "********",
                            isPasswordField: true,
                            maxLength: 15,
                          ),
                          SizedBox(
                            height: ResponsiveSizeConstants.heightScreen(
                                context) * 0.05,
                          ),
                          _getResetFilledButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
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
            if(context.read<ValidationUserCubit>().isNewPasswordEqualToConfirmPassword(_newPasswordController.text, _confirmPasswordController.text)){
              context.read<ValidationUserCubit>().updateUserPasswordByEmail(widget.email, _confirmPasswordController.text);
            }
          }
        },
        text: "Reset",
        textStyle: Theme.of(context).textTheme.displayLarge,
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
