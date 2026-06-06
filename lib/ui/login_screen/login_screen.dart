import 'dart:developer';

import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/login_screen/login_cubit.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_gesture_detector_authentication_screen.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:cinema_app/utils/components/default_user_authentication_screen.dart';
import 'package:cinema_app/utils/components/invalid_user_account_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final bool isLandscape = ResponsiveSizeConstants.isLandscape(context);

    return DefaultGestureDetectorAuthenticationScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login", style: (isLandscape)? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.displaySmall),
        ),
        body: BlocConsumer<LoginCubit , LoginState>(
            listener: (context , state) {
              FocusScope.of(context).unfocus();
              if(state is UserAccountExistFailedState){
                ScaffoldMessenger.of(context).showSnackBar(InvalidUserAccountSnackBar.get(context , isLandscape));
              }
              else if(state is UserAccountExistSuccessState){
                context.go(RoutesConstants.layoutScreen);
              }
            },
            builder: (context , state) {
              return DefaultUserAuthenticationScreen(
                globalKey: _globalKey,
                padding: EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.05, vertical: 35),
                children: [
                  ...defaultAuthenticationTitleAndSubtitle(title: "Welcome back!", subTitle: "Please enter your details", isLandscape: isLandscape ,context: context),
                  SizedBox(
                    height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.05 : ResponsiveSizeConstants.heightScreen(context) * 0.07,
                  ),
                  DefaultTextFormField(
                      controller: _emailController,
                      validator: null,
                      label: "Email Address",
                      hint: "guest@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      maxLength: 30,
                      isLandscape: isLandscape,
                  ),
                  SizedBox(
                    height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.03 :ResponsiveSizeConstants.heightScreen(context) * 0.02,
                  ),
                  DefaultTextFormField(
                      controller: _passwordController,
                      validator: null,
                      label: "Password",
                      hint: "********",
                      isPasswordField: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 15,
                      isLandscape: isLandscape,
                  ),
                  _getDoNotHaveAnAccountAndForgetPasswordTextButton(context , isLandscape),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.04,
                  ),
                  _getLoginFilledButton(context , isLandscape),
                ],
              );
            }
        ),
      ),
    );
  }

  Padding _getLoginFilledButton(BuildContext context, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          context.read<LoginCubit>().isUserAccountExist(_emailController.text, _passwordController.text);
        },
        text: "Login",
        textStyle: (isLandscape)? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.displayLarge,
        isLandscape: isLandscape,
      ),
    );
  }

  Widget _getDoNotHaveAnAccountAndForgetPasswordTextButton(BuildContext context , bool isLandscape) {
    return Padding(
      padding: (isLandscape) ? EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.03) : const EdgeInsets.all(0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              context.pushNamed(RoutesConstants.signupScreen);
            },
            child: Text(
              "Do not have an account ?",
              style: (isLandscape) ? Theme.of(context).textTheme.headlineMedium : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              context.pushNamed(RoutesConstants.forgetPasswordScreen);
            },
            child: Text(
              "Forgot Password ?",
              style: (isLandscape) ? Theme.of(context).textTheme.headlineMedium : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
