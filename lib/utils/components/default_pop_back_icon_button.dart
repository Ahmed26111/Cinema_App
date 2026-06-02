import 'package:flutter/material.dart';

class DefaultPopBackIconButton extends StatelessWidget {
  const DefaultPopBackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }
}
