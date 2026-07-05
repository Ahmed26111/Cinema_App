import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../utils/shared/hive_handler.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile", style: TextStyle(color: Colors.white)),
            IconButton(
              onPressed: () {
                HiveHandler.deleteActiveUser();
              },
              icon: Icon(
                Icons.logout, color: ColorsManager.whiteColor, size: 25,),
            ),
          ],
        ),
      ),
    );
  }
}
