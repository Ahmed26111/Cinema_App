import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "On Boarding Screen",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
