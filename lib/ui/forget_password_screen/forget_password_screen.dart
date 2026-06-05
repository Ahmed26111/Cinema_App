import 'dart:developer';

import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_cubit.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_gesture_detector_authentication_screen.dart';
import 'package:cinema_app/utils/components/default_pop_back_icon_button.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
import 'package:cinema_app/utils/components/default_user_authentication_screen.dart';
import 'package:cinema_app/utils/components/email_doesnot_exist_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =  ResponsiveSizeConstants.isLandscape(context);

    return DefaultGestureDetectorAuthenticationScreen(
      child: Scaffold(
        appBar: AppBar(
            leading: DefaultPopBackIconButton(),
            automaticallyImplyLeading: false, //? to hide default back button
        ),
        body: BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
          listener: (context,state){
            FocusScope.of(context).unfocus();
            if(state is IsEmailExistsFailed){
              ScaffoldMessenger.of(context).showSnackBar(EmailDoesNotExistSnackBar.get(context , isLandscape));
            }else if(state is IsEmailExistsSuccess){
              context.pushNamed(RoutesConstants.createNewPasswordScreenName , pathParameters: {"email": _emailController.text});
            }
          },
          builder: (context,state){
            return DefaultUserAuthenticationScreen(
              globalKey: _globalKey,
              padding: EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.05, vertical: 35),
              children: [
                ...defaultAuthenticationTitleAndSubtitle(title: "Reset Password", subTitle: "Recover your account password", context: context , isLandscape: isLandscape),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.05 :ResponsiveSizeConstants.heightScreen(context) * 0.07,
                ),
                DefaultTextFormField(
                  controller: _emailController,
                  validator: null,
                  label: "Email Address",
                  hint: "guest@gmail.com",
                  textInputType: TextInputType.emailAddress,
                  maxLength: 30,
                  isLandscape: isLandscape,
                ),
                SizedBox(
                  height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.06 : ResponsiveSizeConstants.heightScreen(context) * 0.05,
                ),
                _getNextFilledButton(context , isLandscape),
              ],
            );
          }
        ),
      ),
    );
  }

  Padding _getNextFilledButton(BuildContext context , bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: () {
          if(_globalKey.currentState!.validate()){
            context.read<ForgetPasswordCubit>().isEmailExists(_emailController.text);
          }
        },
        text: "Next",
        textStyle: (isLandscape)? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.displayLarge,
        isLandscape: isLandscape,
      ),
    );
  }



}
