import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.displaySmall),
      ),
      body: Center(
        child: Column(
          children: [
            _getDoNotHaveAnAccountAndForgetPasswordTextButton(context),
          ],
        ),
      ),
    );
  }

  Padding _getDoNotHaveAnAccountAndForgetPasswordTextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
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
      ),
    );
  }
}
