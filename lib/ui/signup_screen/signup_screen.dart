import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/ui/signup_screen/validation_user_cubit.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15,),
              child: Column(
                children: [
                  Text(
                    "Let's get started",
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.005,
                  ),
                  Text(
                    "The latest movie and series are here",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.03,
                  ),
                  DefaultTextFormField(
                    controller: _firstNameController,
                    label: "First Name",
                    hint: "guest",
                    validator: _getNameValidator,
                    maxLength: 15,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                  ),
                  DefaultTextFormField(
                    controller: _lastNameController,
                    label: "Last Name",
                    hint: "guest",
                    validator: _getNameValidator,
                    maxLength: 15,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                  ),
                  DefaultTextFormField(
                    controller: _emailController,
                    label: "Email Address",
                    hint: "guest@gmail.com",
                    validator: _getEmailValidator,
                    maxLength: 30,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                  ),
                  DefaultTextFormField(
                    controller: _passwordController,
                    label: "Password",
                    hint: "********",
                    validator: _getPasswordValidator,
                    maxLength: 15,
                    textInputType: TextInputType.visiblePassword,
                    isPasswordField: true,
                  ),
                  BlocBuilder<ValidationUserCubit,ValidationUserState>(
                    builder: (context , state) {
                      return _getIAgreeTermsConditionListTile(state, context);
                    }
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.05,
                  ),
                  BlocBuilder<ValidationUserCubit,ValidationUserState>(
                    builder: (context , state) {
                      return _getSignupFilledButton(context, state);
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _getSignupFilledButton(BuildContext context, ValidationUserState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveSizeConstants.heightScreen(context) * 0.06,
        child: DefaultUserAuthenticationFilledButton(
          onPressed: (state.isAcceptTerms) ? () {
              if (_globalKey.currentState!.validate()) {
                if (context.read<ValidationUserCubit>().addNewUser(
                    _firstNameController.text,
                    _lastNameController.text,
                    _emailController.text,
                    _passwordController.text
                )
                ) {
                  context.go(RoutesConstants.homeScreen);
                }
              }
            } : null,
          text: "Sign Up",
          textStyle: (state.isAcceptTerms)
              ? Theme.of(context).textTheme.displayLarge
              : TextStyle(color: ColorsManager.primaryDarkColor),
        ),
      ),
    );
  }

  CheckboxListTile _getIAgreeTermsConditionListTile(ValidationUserState state, BuildContext context) {
    return CheckboxListTile(
      value: state.isAcceptTerms,
      onChanged: (value) {
        context.read<ValidationUserCubit>().toggleAcceptTerms();
      },
      title: _getRichText(context),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: ColorsManager.whiteColor,
      activeColor: ColorsManager.primaryBlueAccentColor,
    );
  }

  Column _getRichText(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "I agree to the",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              " Terms and Services",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              " and",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              " Privacy Policy",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
  String? _getNameValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }

    if (text.contains(" ")) {
      return "Please do not add space to your name";
    }

    if (text.length <= 1) {
      return "this is too short for name , please try again";
    }

    if (!Validation.isValidateName(text)) {
      return "Please enter your name in english";
    }

    return null;
  }
  String? _getEmailValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }

    if (text.contains(" ")) {
      return "Please do not add space to your email";
    }

    if(text.length <= 11){
      return "please , Enter you email at this format \"yourname@gmail.com\" ";
    }

    String ? beforeAtGmailDotCom = text.substring(0 , text.length - 10);

    if(! text.endsWith("@gmail.com")){
      return "please , Enter you email at this format \"yourname@gmail.com\" ";
    }

    if (!(Validation.isValidateEmail(beforeAtGmailDotCom))) {
      return "Please enter your email in english without special character";
    }

    if(! context.read<ValidationUserCubit>().isUniqueUserEmail(text)){
      return "This Email already used in another user account";
    }

    return null;
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





// ?
