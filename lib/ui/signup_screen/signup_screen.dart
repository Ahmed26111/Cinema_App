import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up" , style: Theme.of(context).textTheme.displaySmall,),
      ),
      body: Center(child: Text("Sign Up")),
    );
  }
}
