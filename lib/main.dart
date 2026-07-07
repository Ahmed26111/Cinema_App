import 'dart:developer';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:cinema_app/ui/favourite_movies_screen/favourite_movies_state_management/favourite_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/ui/watch_list_movies_screen/watch_list_movies_state_management/watch_list_movies_cubit.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:cinema_app/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHandler.init();
  await dotenv.load(fileName: "keys.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ProfileCubit()..getActiveUser()),
        BlocProvider(
          create: (context) => FavouriteMoviesCubit()..getFavouriteMovies(),
        ),
        BlocProvider(
          create: (context) => WatchListMoviesCubit()..getWatchListMovies(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.getLightThemeData(context),
        routerConfig: RoutesManager.routes,
      ),
    );
  }
}
