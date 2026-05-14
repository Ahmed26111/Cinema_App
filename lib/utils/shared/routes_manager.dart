import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesManager {
  static final GoRouter routes = GoRouter(
      initialLocation: RoutesConstants.splashScreen,
      routes: <RouteBase>[
        GoRoute(
            path: RoutesConstants.splashScreen,
            builder: (context , state){
              // TODO return widget Screen
              return Placeholder();
            }
        ),

      ]
  );
}
