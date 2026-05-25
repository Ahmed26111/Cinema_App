import 'dart:developer';

import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/signup_screen/validation_user_cubit.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
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
    FocusManager.instance.primaryFocus?.unfocus();
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login", style: Theme.of(context).textTheme.displaySmall),
        ),
        body: BlocConsumer<ValidationUserCubit,ValidationUserState>(
            listener: (context , state) {
              FocusScope.of(context).unfocus();
              if(state is ValidationUserIsUniqueUserAccountExistFailed){
                ScaffoldMessenger.of(context).showSnackBar(InvalidUserAccountSnackBar.get(context));
              }
              else if(state is ValidationUserIsUniqueUserAccountExistSuccess){
                context.go(RoutesConstants.homeScreen);
              }
            },
            builder: (context , state) {
              return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18 ,vertical: 22),
                    child: Column(
                      children: [
                        ...defaultAuthenticationTitleAndSubtitle(title: "Welcome back!", subTitle: "Please enter your details", context: context),
                        SizedBox(
                          height: ResponsiveSizeConstants.heightScreen(context) * 0.07,
                        ),
                        DefaultTextFormField(
                            controller: _emailController,
                            validator: null,
                            label: "Email Address",
                            hint: "guest@gmail.com",
                            textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                        ),
                        DefaultTextFormField(
                            controller: _passwordController,
                            validator: null,
                            label: "Password",
                            hint: "********",
                            isPasswordField: true,
                            textInputType: TextInputType.visiblePassword,
                        ),
                        _getDoNotHaveAnAccountAndForgetPasswordTextButton(context),
                        SizedBox(
                          height: ResponsiveSizeConstants.heightScreen(context) * 0.04,
                        ),
                        _getLoginFilledButton(context),
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

  Padding _getLoginFilledButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          context.read<ValidationUserCubit>().isUserAccountExist(_emailController.text, _passwordController.text);
        },
        text: "Login",
        textStyle: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Row _getDoNotHaveAnAccountAndForgetPasswordTextButton(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.pushNamed(RoutesConstants.signupScreen);
          },
          child: Text(
            "Do not have an account ?",
            style: Theme.of(context).textTheme.bodyMedium,
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
