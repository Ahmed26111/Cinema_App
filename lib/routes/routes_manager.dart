import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/ui/core/layout/change_bottom_navigation_bar_index_cubit.dart';
import 'package:cinema_app/ui/core/layout/layout_screen.dart';
import 'package:cinema_app/ui/create_new_password_screen/create_new_password_cubit.dart';
import 'package:cinema_app/ui/create_new_password_screen/create_new_password_screen.dart';
import 'package:cinema_app/ui/details_movie_screen/cast_cubit/cast_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/details_movie_cubit/details_movie_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/details_movie_screen.dart';
import 'package:cinema_app/ui/details_movie_screen/movie_certification_cubit/movie_certification_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/similar_movies_cubit/similar_movies_cubit.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_cubit.dart';
import 'package:cinema_app/ui/forget_password_screen/forget_password_screen.dart';
import 'package:cinema_app/ui/home_screen/home_screen.dart';
import 'package:cinema_app/ui/login_screen/login_cubit.dart';
import 'package:cinema_app/ui/login_screen/login_screen.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_change_index_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_layout_screen.dart';
import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/ui/search_result_screen/search_result_cubit.dart';
import 'package:cinema_app/ui/search_result_screen/search_result_screen.dart';
import 'package:cinema_app/ui/show_your_seat_screen/show_your_seat_screen.dart';
import 'package:cinema_app/ui/signup_screen/signup_cubit.dart';
import 'package:cinema_app/ui/signup_screen/signup_screen.dart';
import 'package:cinema_app/ui/splash_screen/get_active_user_cubit.dart';
import 'package:cinema_app/ui/on_boarding_screen/onboarding_screen1.dart';
import 'package:cinema_app/ui/splash_screen/splash_screen.dart';
import 'package:cinema_app/ui/tickets_reserve_screen/tickets_reserve_cubit/tickets_reserve_cubit.dart';
import 'package:cinema_app/ui/tickets_reserve_screen/tickets_reserve_screen.dart';
import 'package:cinema_app/utils/components/default_see_all_movies_widget.dart';
import 'package:cinema_app/utils/shared/get_selected_date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../ui/home_screen/get_popular_movies_state_management/get_popular_movies_cubit.dart';
import '../ui/home_screen/get_top_rated_movies_state_management/get_top_rated_movies_cubit.dart';
import '../ui/home_screen/get_upcoming_movies_state_management/get_upcoming_movies_cubit.dart';
import '../ui/home_screen/home_state_management/home_cubit.dart';
import '../ui/tickets_screen/tickets_state_management/tickets_cubit.dart';

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
        path: RoutesConstants.layoutScreen,
        name: RoutesConstants.layoutScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 700),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChangeBottomNavigationBarIndexCubit(),
              ),
              BlocProvider(
                create: (context) => TicketsCubit()..getUserTickets(),
              ),
              BlocProvider(
                create: (context) => GetTopRatedMoviesCubit()..getTopRatedMovies(),
              ),
              BlocProvider(
                create: (context) => HomeCubit(),
              ),
              BlocProvider(
                create: (context) => GetUpcomingMoviesCubit()..getUpComingMovies(),
              ),
              BlocProvider(
                create: (context) => GetPopularMoviesCubit()..getPopularMovies(),
              ),
              BlocProvider(
                create: (context) => ProfileCubit()..getActiveUser(),
              ),
            ],
            child: LayoutScreen(),
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
      ),
      GoRoute(
        name: RoutesConstants.defaultSeeAllScreenName,
        path: RoutesConstants.defaultSeeAllScreenUrl,
        pageBuilder: (context ,state) {
          final movies = state.extra as List<MovieModel>;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Duration(milliseconds: 200),
            child: DefaultSeeAllMoviesWidget(appBarTitle: state.pathParameters["appBarTitle"]!, movies: movies),
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
          );
        },
      ),
      GoRoute(
        name: RoutesConstants.searchResultScreen,
        path: RoutesConstants.searchResultScreen,
        pageBuilder: (context ,state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Duration(milliseconds: 200),
            child: BlocProvider(
              create: (context) => SearchResultCubit(),
              child: SearchResultScreen(),
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
      ),
      GoRoute(
        name: RoutesConstants.detailsMovieScreenName,
        path: RoutesConstants.detailsMovieScreenUrl,
        pageBuilder: (context ,state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Duration(milliseconds: 200),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DetailsMovieCubit()..getDetailsMovieModel(int.parse(state.pathParameters["movieId"] ?? "-1")),
                ),
                BlocProvider(
                  create: (context) => MovieCertificationCubit()..getMovieCertification(int.parse(state.pathParameters["movieId"] ?? "-1")),
                ),
                BlocProvider(
                  create: (context) => CastCubit()..getCastsByMovieId(int.parse(state.pathParameters["movieId"] ?? "-1")),
                ),
                BlocProvider(
                  create: (context) => SimilarMoviesCubit()..getSimilarMoviesByMovieId(int.parse(state.pathParameters["movieId"] ?? "-1")),
                ),
              ],
              child: DetailsMovieScreen(movieId: int.parse(state.pathParameters["movieId"] ?? "-1")),
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
      ),
      GoRoute(
        path: RoutesConstants.ticketsReserveScreen,
        name: RoutesConstants.ticketsReserveScreen,
        pageBuilder: (context, state) {
          final MovieModel movie = state.extra as MovieModel;
          final DateTime selectedDate = getSelectedDateTime(movie.releaseDate);
          return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => TicketsReserveCubit(selectedDate)..getSeats(movie.movieId),
            child: TicketsReserveScreen(movieModel: movie),
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
        );
        },
      ),
      GoRoute(
        path: RoutesConstants.showYourSeatScreenUrl,
        name: RoutesConstants.showYourSeatScreenName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Duration(milliseconds: 200),
          child: ShowYourSeatScreen(moviePosterImage: state.pathParameters["moviePosterImage"] ?? "", movieTitle: state.pathParameters["movieTitle"] ?? "" , seatNumber: state.pathParameters["seatNumber"] ?? "",),
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
        );
        },
      ),
    ],
  );
}
