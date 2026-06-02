import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

class DefaultUserAuthenticationScreen extends StatelessWidget {

  final GlobalKey<FormState>? globalKey;

  final EdgeInsetsGeometry padding;

  final List<Widget> children;

  const DefaultUserAuthenticationScreen({super.key, this.globalKey, required this.padding, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: padding,
            child: Column(
                children: children
            ),
          ),
        ),
      ),
    );
  }
}
