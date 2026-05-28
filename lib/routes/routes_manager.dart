import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/ui/create_new_password_screen/create_new_password_cubit.dart';
import 'package:cinema_app/ui/create_new_password_screen/create_new_password_screen.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_cubit.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_screen.dart';
import 'package:cinema_app/ui/home_screen/home_screen.dart';
import 'package:cinema_app/ui/login_screen/login_cubit.dart';
import 'package:cinema_app/ui/login_screen/login_screen.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_change_index_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_layout_screen.dart';
import 'package:cinema_app/ui/signup_screen/signup_cubit.dart';
import 'package:cinema_app/ui/signup_screen/signup_screen.dart';
import 'package:cinema_app/ui/splash_screen/get_active_user_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen1.dart';
import 'package:cinema_app/ui/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesManager {
  static final GoRouter routes = GoRouter(
    initialLocation: RoutesConstants.splashScreen,
    routes: <RouteBase>[
      GoRoute(
        name: RoutesConstants.splashScreen,
        path: RoutesConstants.splashScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => GetActiveUserCubit(),
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: RoutesConstants.onboardingLayoutScreen,
        name: RoutesConstants.onboardingLayoutScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 700),
          child: BlocProvider(
            create: (context) => OnboardingChangeIndexCubit(),
            child: OnboardingLayoutScreen(),
          ),
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
        name: RoutesConstants.homeScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
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
      GoRoute(
        path: RoutesConstants.loginScreen,
        name: RoutesConstants.loginScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 500),
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
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
        path: RoutesConstants.signupScreen,
        name: RoutesConstants.signupScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => SignupCubit(),
            child: SignupScreen(),
          ),
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
        path: RoutesConstants.forgetPasswordScreen,
        name: RoutesConstants.forgetPasswordScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => ForgetPasswordCubit(),
            child: ForgetPasswordScreen(),
          ),
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
        name: RoutesConstants.createNewPasswordScreenName,
        path: RoutesConstants.createNewPasswordScreenUrl,
        pageBuilder: (context ,state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Duration(milliseconds: 200),
            child: BlocProvider(
              create: (context) => CreateNewPasswordCubit(),
              child: CreateNewPasswordScreen(email: state.pathParameters["email"]!),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation,
                child) {
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
          );
        },
      )
    ],
  );
}
