import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          spacing: 100,
          children: [
            Text("Welcome ${HiveHandler.getActiveUser()!.firstName}"),
            Text(
              "Home Screen",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            IconButton(
                onPressed: (){
                  HiveHandler.deleteActiveUser();
                },
                icon: Icon(Icons.dangerous)
            ),
          ],
        ),
      ),
    );
  }
}
