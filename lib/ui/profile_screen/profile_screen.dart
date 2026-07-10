import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/utils/components/account_deleted_successfully_snack_bar.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/log_out_successfully_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../data/models/user/user_model.dart';
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
              return SingleChildScrollView(
                child: Center(
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
                              context.pushNamed(RoutesConstants.editProfileScreen);
                            },
                            icon: Icon(Icons.edit_square),
                            iconSize: 25,
                            color: ColorsManager.primaryBlueAccentColor,
                        ),
                      ),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                      _getDefaultCardInfo(Padding(
                        padding: const EdgeInsets.only(left: 14 , top: 24 ,bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("General" , style: Theme.of(context).textTheme.displaySmall,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.favorite_outlined , color: ColorsManager.redColor,size: 25,),
                              ),
                              title: Text("Favourite movies" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  context.pushNamed(RoutesConstants.favouriteMoviesScreen);
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            Divider(color: ColorsManager.primarySoftColor, indent: 14, endIndent: 30,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.bookmark , color: ColorsManager.orangeColor,size: 25,),
                              ),
                              title: Text("Watch list movies" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  context.pushNamed(RoutesConstants.watchListMoviesScreen);
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                      _getDefaultCardInfo(Padding(
                        padding: const EdgeInsets.only(left: 14 , top: 24 ,bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Account" , style: Theme.of(context).textTheme.displaySmall,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.lock_outline , color: ColorsManager.greyColor,size: 25,),
                              ),
                              title: Text("Change Password" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  context.pushNamed(RoutesConstants.changePasswordScreen);
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            Divider(color: ColorsManager.primarySoftColor, indent: 14, endIndent: 30,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.person_remove , color: ColorsManager.greyColor,size: 25,),
                              ),
                              title: Text("Delete Account" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  showDialog(context: context, barrierDismissible: false ,builder: (context){
                                    return AlertDialog(
                                      backgroundColor: ColorsManager.primarySoftColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 10),
                                          Image.asset("images/warning.png"),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Are you sure you want to",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.labelLarge,
                                          ),
                                          Text(
                                            "Delete Account?",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: ColorsManager.redColor,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            "Be careful the account",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.labelLarge,
                                          ),
                                          Text(
                                            "will not return back",
                                            textAlign: TextAlign.center,
                                            style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                                                color: ColorsManager.redColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: ColorsManager.greyColor),
                                          ),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            deleteAccount();
                                            ScaffoldMessenger.of(context).showSnackBar(AccountDeletedSuccessfullySnackBar.get(context));
                                            context.go(RoutesConstants.loginScreen);
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor: ColorsManager.redColor,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  });
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                      _getDefaultCardInfo(Padding(
                        padding: const EdgeInsets.only(left: 14 , top: 24 ,bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("More" , style: Theme.of(context).textTheme.displaySmall,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.shield , color: ColorsManager.greyColor,size: 25,),
                              ),
                              title: Text("Legal and Policies" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  context.pushNamed(RoutesConstants.legalAndPoliciesScreen);
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            Divider(color: ColorsManager.primarySoftColor, indent: 14, endIndent: 30,),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorsManager.primarySoftColor,
                                radius: 20,
                                child: Icon(Icons.info , color: ColorsManager.greyColor,size: 25,),
                              ),
                              title: Text("About Us" , style: Theme.of(context).textTheme.labelMedium,),
                              trailing: IconButton(
                                onPressed: (){
                                  context.pushNamed(RoutesConstants.aboutUsScreen);
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 20,
                                color: ColorsManager.primaryBlueAccentColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){
                                showDialog(context: context, barrierDismissible: false ,builder: (context){
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
                                          "Are you sure you want to\nLogout?",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                      ],
                                    ),
                                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: ColorsManager.greyColor),
                                        ),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          HiveHandler.deleteActiveUser();
                                          ScaffoldMessenger.of(context).showSnackBar(LogOutSuccessfullySnackBar.get(context));
                                          context.go(RoutesConstants.loginScreen);
                                        },
                                        style: FilledButton.styleFrom(
                                          backgroundColor: ColorsManager.primaryBlueAccentColor,
                                        ),
                                        child: const Text("Logout"),
                                      ),
                                    ],
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: ColorsManager.primaryBlueAccentColor , width: 1),
                                backgroundColor: ColorsManager.primaryDarkColor,
                              ),
                              child: Text("Log Out" , style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05,
                                fontWeight: FontWeight.bold
                              ),)
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget _getDefaultCardInfo(Widget ? child){
    return Card(
      color: ColorsManager.primaryDarkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(width: 2 , color: ColorsManager.primarySoftColor),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14 , vertical: 8),
      child: child,
    );
  }

  void deleteAccount(){
    final UserModel ? activeUser = HiveHandler.getActiveUser();
    HiveHandler.deleteActiveUser();
    HiveHandler.deleteUser(activeUser?.userId ?? "");
    List<TicketModel> tickets = HiveHandler.getReservedTickets();
    if(activeUser != null) {
      tickets = tickets.where((ticket) {
        return (ticket.userId != activeUser.userId);
      }).toList();
    }
    HiveHandler.addAndUpdateReservedTickets(tickets);
  }
}
