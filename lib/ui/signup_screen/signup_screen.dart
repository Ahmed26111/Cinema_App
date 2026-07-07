import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_gesture_detector_authentication_screen.dart';
import 'package:cinema_app/utils/components/default_pop_back_icon_button.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:cinema_app/utils/components/default_user_authentication_screen.dart';
import 'package:cinema_app/utils/components/failed_to_add_new_user_snack_bar.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'signup_cubit.dart';

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
    final bool isLandscape = ResponsiveSizeConstants.isLandscape(context);

    return DefaultGestureDetectorAuthenticationScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "Sign Up",
              style: (isLandscape)? Theme.of(context).textTheme.labelLarge :Theme.of(context).textTheme.displaySmall
          ),
          leading: DefaultPopBackIconButton(),
          automaticallyImplyLeading: false, //? to hide default back button
        ),
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
              FocusScope.of(context).unfocus();
              if(state is AddNewUserSuccessState){
                context.go(RoutesConstants.layoutScreen);
              }
              else if(state is AddNewUserFailedState){
                ScaffoldMessenger.of(context).showSnackBar(FailedToAddNewUserSnackBar.get(context , isLandscape));
              }
          },
          builder: (context, state) {
            return DefaultUserAuthenticationScreen(
              globalKey: _globalKey,
              padding:  EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.05, vertical: 15,),
              children: [
                ...defaultAuthenticationTitleAndSubtitle(
                    title: "Let's get started",
                    subTitle: "The latest movie and series are here",
                    isLandscape: isLandscape,
                    context: context,
                ),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.02 : ResponsiveSizeConstants.heightScreen(context) * 0.03,
                ),
                DefaultTextFormField(
                  controller: _firstNameController,
                  label: "First Name",
                  hint: "guest",
                  validator: _getNameValidator,
                  maxLength: 15,
                  textInputType: TextInputType.name,
                  isLandscape: isLandscape,
                ),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.03 : ResponsiveSizeConstants.heightScreen(context) * 0.02,
                ),
                DefaultTextFormField(
                  controller: _lastNameController,
                  label: "Last Name",
                  hint: "guest",
                  validator: _getNameValidator,
                  maxLength: 15,
                  isLandscape: isLandscape,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.03 : ResponsiveSizeConstants.heightScreen(context) * 0.02,
                ),
                DefaultTextFormField(
                  controller: _emailController,
                  label: "Email Address",
                  hint: "guest@gmail.com",
                  validator: _getEmailValidator,
                  maxLength: 30,
                  isLandscape: isLandscape,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.03 : ResponsiveSizeConstants.heightScreen(context) * 0.02,
                ),
                DefaultTextFormField(
                  controller: _passwordController,
                  label: "Password",
                  hint: "********",
                  validator: _getPasswordValidator,
                  maxLength: 15,
                  isLandscape: isLandscape,
                  textInputType: TextInputType.visiblePassword,
                  isPasswordField: true,
                ),
                _getIAgreeTermsConditionListTile(state, context , isLandscape),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.06 : ResponsiveSizeConstants.heightScreen(context) * 0.05,
                ),
                _getSignupFilledButton(context, state , isLandscape),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _getSignupFilledButton(BuildContext context, SignupState state , bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: (state.isAcceptTerms) ? () {
          FocusScope.of(context).unfocus();
          if (_globalKey.currentState!.validate()) {
              context.read<SignupCubit>().addNewUser(
                  _firstNameController.text,
                  _lastNameController.text,
                  _emailController.text,
                  _passwordController.text
              );
          }
        } : null,
        text: "Sign Up",
        textStyle: (state.isAcceptTerms)
            ? (isLandscape)? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.displayLarge
            : TextStyle(color: ColorsManager.primaryDarkColor),
        isLandscape: isLandscape,
      ),
    );
  }

  CheckboxListTile _getIAgreeTermsConditionListTile(SignupState state, BuildContext context , bool isLandscape) {
    return CheckboxListTile(
      value: state.isAcceptTerms,
      onChanged: (value) {
        context.read<SignupCubit>().toggleAcceptTerms();
      },
      title: _getAgreeTermConditionRichText(context,isLandscape),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: ColorsManager.whiteColor,
      activeColor: ColorsManager.primaryBlueAccentColor,
    );
  }

  Widget _getAgreeTermConditionRichText(BuildContext context, bool isLandscape) {
    // Determine the styles based on orientation
    final TextStyle? normalStyle = isLandscape
        ? Theme.of(context).textTheme.bodySmall
        : Theme.of(context).textTheme.titleSmall;

    final TextStyle? linkStyle = isLandscape
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.bodyMedium;

    return RichText(
      text: TextSpan(
        style: normalStyle,
        children: [
          const TextSpan(text: "I agree to the"),
          TextSpan(
            text: " Terms and Services",
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(RoutesConstants.legalAndPoliciesScreen);
              },
          ),
          const TextSpan(text: " and"),
          TextSpan(
            text: " Privacy Policy",
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(RoutesConstants.legalAndPoliciesScreen);
              },
          ),
        ],
      ),
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

    if(! context.read<SignupCubit>().isUniqueUserEmail(text)){
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

