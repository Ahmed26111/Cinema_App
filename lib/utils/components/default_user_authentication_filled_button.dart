import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class DefaultUserAuthenticationFilledButton extends StatelessWidget {
  const DefaultUserAuthenticationFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textStyle,
  });


  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveSizeConstants.heightScreen(context) * 0.06,
      child: FilledButton(
        onPressed: onPressed ,
        style: ThemeManager.getOnboardingFilledButtonStyle()
            .copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
