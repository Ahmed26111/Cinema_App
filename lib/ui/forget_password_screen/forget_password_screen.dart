import 'dart:developer';

import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_cubit.dart';
import 'package:cinema_app/utils/components/default_authentication_title_and_subtitle.dart';
import 'package:cinema_app/utils/components/default_text_form_field.dart';
import 'package:cinema_app/utils/components/default_user_authentication_filled_button.dart';
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
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)
            ),
            automaticallyImplyLeading: false, //? to hide default back button
        ),
        body: BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
          listener: (context,state){
            FocusScope.of(context).unfocus();
            if(state is IsEmailExistsFailed){
              ScaffoldMessenger.of(context).showSnackBar(EmailDoesNotExistSnackBar.get(context));
            }else if(state is IsEmailExistsSuccess){
              context.pushNamed(RoutesConstants.createNewPasswordScreenName , pathParameters: {"email": _emailController.text});
            }
          },
          builder: (context,state){
            return SingleChildScrollView(
              child: Center(
                  child: Form(
                    key: _globalKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
                      child: Column(
                        children: [
                          ...defaultAuthenticationTitleAndSubtitle(title: "Reset Password", subTitle: "Recover your account password", context: context),
                          SizedBox(
                            height: ResponsiveSizeConstants.heightScreen(context) * 0.07,
                          ),
                          DefaultTextFormField(
                            controller: _emailController,
                            validator: null,
                            label: "Email Address",
                            hint: "guest@gmail.com",
                            textInputType: TextInputType.emailAddress,
                            maxLength: 30,
                          ),
                          SizedBox(
                            height: ResponsiveSizeConstants.heightScreen(context) * 0.05,
                          ),
                          _getNextFilledButton(context),
                        ],
                      ),
                    ),
                  )
              ),
            );
          }
        ),
      ),
    );
  }

  Padding _getNextFilledButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: () {
          if(_globalKey.currentState!.validate()){
            context.read<ForgetPasswordCubit>().isEmailExists(_emailController.text);
          }
        },
        text: "Next",
        textStyle: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }



}
