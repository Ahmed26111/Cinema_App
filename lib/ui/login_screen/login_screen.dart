import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18 ,vertical: 22),
              child: Column(
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.005,
                  ),
                  Text(
                    "Please enter you details",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.07,
                  ),
                  DefaultTextFormField(
                      controller: _emailController,
                      validator: null,
                      label: "Email Address",
                      hint: "guest@gmail.com",
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
      ),
    );
  }

  Padding _getLoginFilledButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveSizeConstants.heightScreen(context) * 0.065,
        child: DefaultUserAuthenticationFilledButton(
          onPressed: () {
            // TODO validate on email and password in the database
            //  -> found -> go to home screen
            //  -> not found -> show invalid email or password message

          },
          text: "Login",
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }

  Row _getDoNotHaveAnAccountAndForgetPasswordTextButton(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
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
