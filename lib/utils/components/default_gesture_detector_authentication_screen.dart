import 'package:flutter/material.dart';

class DefaultGestureDetectorAuthenticationScreen extends StatelessWidget {
  const DefaultGestureDetectorAuthenticationScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //? onTap to hide keyboard
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
