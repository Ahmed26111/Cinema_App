import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/home_screen/home_screen.dart';
import 'package:cinema_app/ui/on_boarding_screen/get_active_user_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen.dart';
import 'package:cinema_app/ui/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesManager {
  static final GoRouter routes = GoRouter(
    initialLocation: RoutesConstants.splashScreen,
    routes: <RouteBase>[
      GoRoute(
        path: RoutesConstants.splashScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => GetActiveUserCubit(),
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: RoutesConstants.onboardingScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 700),
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: RoutesConstants.homeScreen,
        pageBuilder: (context , state) => CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Duration(milliseconds: 700),
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
                  child: child,
                ),
              );
            },
        ),
      ),
    ],
  );
}
