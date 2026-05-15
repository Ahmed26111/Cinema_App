import 'dart:async';

import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/on_boarding_screen/get_active_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 2) ,
        (){
          UserModel? activeUser = context.read<GetActiveUserCubit>().getActiveUser();
          if(activeUser == null){
            context.go(RoutesConstants.onboardingScreen);
          }
          else{
            context.go(RoutesConstants.homeScreen);
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset(
            "images/cinemax_img.png",
            width: ResponsiveSizeConstants.widthScreen(context),
            height: ResponsiveSizeConstants.heightScreen(context) * 0.8,
            fit: BoxFit.contain,
          ),
        ]
      ),
    );
  }
}
