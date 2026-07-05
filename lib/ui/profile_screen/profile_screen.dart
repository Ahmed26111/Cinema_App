import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../utils/shared/hive_handler.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Profile",
            style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<ProfileCubit,ProfileState>(
        builder: (context, state) {
          switch(state){
            case ProfileInitial() || GetActiveUserLoading():{
              return Skeletonizer(
                  child: Container()
              );
            }
            case GetActiveUserSuccessfully():{
              return Center(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorsManager.transparent,
                        foregroundColor: ColorsManager.transparent,
                        foregroundImage: AssetImage("images/default_male_avatar.png"),
                        radius: 30,
                      ),
                      title: Text(
                        "${state.activeUser.firstName} ${state.activeUser.lastName}" ,
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        state.activeUser.email ,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                          onPressed: (){
                            //Todo push to edit profile
                          },
                          icon: Icon(Icons.edit_square),
                          iconSize: 25,
                          color: ColorsManager.primaryBlueAccentColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            case GetActiveUserFailed():{
              return DefaultFailedToLoadWidget(
                  errorMessage: "Failed to get active user",
                  helpMessage: "Please try to restart application"
              );
            }
          }
        },
      ),
    );
  }
}
