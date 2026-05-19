import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                ),
                Text(
                  "Let's get started",
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * 0.005,
                ),
                Text(
                  "The latest movie and series are here",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  child: DefaultTextFormField(
                    controller: _nameController,
                    label: "First Name",
                    hint: "guest",
                    validator: _getFirstNameValidator,
                    maxLength: 15,
                    textInputType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.06,
                    child: FilledButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          // TODO after validation
                        }
                      },
                      style: ThemeManager.getOnboardingFilledButtonStyle()
                          .copyWith(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getFirstNameValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }
    if (text.contains(" ")) {
      return "Please do not add space to your first name";
    }
    for (int i = 0; i < text.length; i++) {
      if (!((text.codeUnitAt(i) >= 65 && text.codeUnitAt(i) <= 90) ||
          (text.codeUnitAt(i) >= 97 && text.codeUnitAt(i) <= 122))) {
        return "Please enter your first name in english";
      }
    }

    if(text.length <= 2 ){
      return "this is too short for first name , please try again";
    }
    return null;
  }

}
