import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/edit_profile_screen/edit_profile_state_management/edit_profile_cubit.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/utils/components/default_gesture_detector_authentication_screen.dart';
import 'package:cinema_app/utils/components/default_user_authentication_screen.dart';
import 'package:cinema_app/utils/components/edit_profile_successfully_snack_bar.dart';
import 'package:cinema_app/utils/components/failed_to_edit_profile_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';
import '../../utils/components/default_text_form_field.dart';
import '../../utils/components/default_user_authentication_filled_button.dart';
import '../../utils/shared/debouncer.dart';
import '../../utils/shared/validation.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late UserModel ? activeUser;

  final Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 150));

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    activeUser = context.read<EditProfileCubit>().getActiveUser();
    _firstNameController.text = activeUser?.firstName ?? "";
    _lastNameController.text = activeUser?.lastName ?? "";
    _emailController.text = activeUser?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {

    return DefaultGestureDetectorAuthenticationScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile" , style: Theme.of(context).textTheme.displaySmall,),
          leading: _getBackFilledIconButton(context),
          leadingWidth: 80,
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<EditProfileCubit , EditProfileState>(
          listener: (context , state) async {
            FocusManager.instance.primaryFocus?.unfocus();
            // 2. Wait for the closing animation to finish (approx 300ms)
            await Future.delayed(const Duration(milliseconds: 300));

            if (!context.mounted) return; // Safety check for async gap

            if(state is EditProfileFailed){
              ScaffoldMessenger.of(context).showSnackBar(FailedToEditProfileSnackBar.get(context));
            }
            else if(state is EditProfileSuccess){
              context.read<ProfileCubit>().getActiveUser();
              context.read<HomeCubit>().getActiveUser();
              ScaffoldMessenger.of(context).showSnackBar(EditProfileSuccessfullySnackBar.get(context));
              context.pop();
            }
          },
          builder: (context , state) {
              return DefaultUserAuthenticationScreen(
                  globalKey: _globalKey,
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.05),
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsManager.transparent,
                      foregroundColor: ColorsManager.transparent,
                      foregroundImage: AssetImage("images/default_male_avatar.png"),
                      radius: 50,
                    ),
                    Text(
                      "${activeUser?.firstName??""} ${activeUser?.lastName??""}" ,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      activeUser?.email ?? "",
                      style: Theme.of(context).textTheme.headlineLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    DefaultTextFormField(
                      controller: _firstNameController,
                      label: "First Name",
                      hint: "guest",
                      validator: _getNameValidator,
                      maxLength: 15,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    DefaultTextFormField(
                      controller: _lastNameController,
                      label: "Last Name",
                      hint: "guest",
                      validator: _getNameValidator,
                      maxLength: 15,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    DefaultTextFormField(
                      controller: _emailController,
                      label: "Email Address",
                      hint: "guest@gmail.com",
                      validator: _getEmailValidator,
                      maxLength: 30,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: ResponsiveSizeConstants.heightScreen(context) * 0.02,
                    ),
                    _getSaveChangesFilledButton(context, state),
                  ],
              );
            },
        ),
      ),
    );
  }

  Padding _getSaveChangesFilledButton(BuildContext context, EditProfileState state) {
    final editProfileCubit = context.read<EditProfileCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DefaultUserAuthenticationFilledButton(
        onPressed: () async {
          // 2. Unfocus again just to be safe before popping
          FocusManager.instance.primaryFocus?.unfocus();

          await Future.delayed(const Duration(milliseconds: 300));
          if (!context.mounted) return; // Safety check for async gap

          if (_globalKey.currentState!.validate()) {
            debouncer.call((){
              showDialog(context: context, barrierDismissible: false ,builder: (dialogContext){
                return AlertDialog(
                  backgroundColor: ColorsManager.primarySoftColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Image.asset("images/are_you_sure.png"),
                      const SizedBox(height: 10),
                      Text(
                        "Are you sure you want to\nSave Changes?",
                        textAlign: TextAlign.center,
                        style: Theme.of(dialogContext).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        "Cancel",
                        style: Theme.of(dialogContext).textTheme.titleSmall,
                      ),
                    ),
                    FilledButton(
                      onPressed: () async{
                        editProfileCubit.editUser(firstName: _firstNameController.text, lastName: _lastNameController.text, email: _emailController.text);
                        dialogContext.pop();
                        // 2. Unfocus again just to be safe before popping
                        FocusManager.instance.primaryFocus?.unfocus();

                        // 2. Wait for the closing animation to finish (approx 300ms)
                        await Future.delayed(const Duration(milliseconds: 300));

                        if (!context.mounted) return; // Safety check for async gap
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorsManager.primaryBlueAccentColor,
                      ),
                      child: Text("Save Changes" , style: Theme.of(dialogContext).textTheme.labelMedium,),
                    ),
                  ],
                );
              });
            });
          }
        },
        text: "Save Changes",
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  IconButton _getBackFilledIconButton(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.pop();
      },
      icon: Icon(Icons.arrow_back_ios_new, color: ColorsManager.whiteColor , size: 20,),
      style: IconButton.styleFrom(
          backgroundColor: ColorsManager.primarySoftColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )
      ),
    );
  }
  String? _getNameValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }

    if (text.contains(" ")) {
      return "Please do not add space to your name";
    }

    if (text.length <= 1) {
      return "this is too short for name , please try again";
    }

    if (!Validation.isValidateName(text)) {
      return "Please enter your name in english";
    }

    return null;
  }
  String? _getEmailValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This Field is required";
    }

    if (text.contains(" ")) {
      return "Please do not add space to your email";
    }

    // Use the shared validation logic for all email types
    if (!Validation.isValidateEmail(text)) {
      return "Please enter a valid email address (e.g., name@example.com)";
    }

    if (!context.read<EditProfileCubit>().isUniqueUserEmail(text)) {
      return "This Email already used in another user account";
    }

    return null;
  }
}
