import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandscape = ResponsiveSizeConstants.isLandscape(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<HomeCubit,HomeState>(
              builder: (context, state){
                UserModel ? activeUser = context.read<HomeCubit>().getActiveUser();
                return Text(
                    (activeUser == null)?"Hello, Guest":"Hello, ${activeUser.firstName}" ,
                    style: (isLandscape)? Theme.of(context).textTheme.titleLarge :Theme.of(context).textTheme.displaySmall,
                );
              },
            ),
            Text(
              "Let`s stream your favourite movie",
              style: (isLandscape)? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        leading: Image.asset("images/circular_avatar.png")
      ),
      body: SingleChildScrollView(
        child: Center(
          child: null,
        ),
      ),
    );
  }
}
