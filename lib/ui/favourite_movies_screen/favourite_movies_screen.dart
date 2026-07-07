import 'package:cinema_app/ui/favourite_movies_screen/favourite_movies_state_management/favourite_movies_cubit.dart';
import 'package:cinema_app/utils/components/default_empty_list_widget.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/get_favourites_or_watch_list_movies_list_view_widget.dart';
import 'package:cinema_app/utils/shared/getDummyMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';

class FavouriteMoviesScreen extends StatelessWidget {
  const FavouriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Movies" , style: Theme.of(context).textTheme.displaySmall,),
        leading: _getBackFilledIconButton(context),
        leadingWidth: 80,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FavouriteMoviesCubit, FavouriteMoviesState>(
          builder: (context , state){
            switch(state){
              case FavouriteMoviesInitial() || FavouriteMoviesLoading():{
                return Column(
                  children: [
                    Expanded(
                      child: Skeletonizer(
                        containersColor: ColorsManager.greyColor,
                        effect: ShimmerEffect(
                          baseColor: ColorsManager.greyColor,
                          highlightColor: ColorsManager.lineDarkColor,
                        ),
                        enabled: true,
                        child: GetFavouritesOrWatchListMoviesListViewWidget(
                            movies: getDummyMovies(10),
                            isDummy: true,
                            isFavourite: true,
                        ),
                      ),
                    ),
                  ],
                );
              }
              case FavouriteMoviesEmpty():{
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultEmptyListWidget(
                          message: "There is no movie yet!",
                          helpMessage: "Find your movie by Type title, categories, years, etc"
                      ),
                    ],
                  ),
                );
              }
              case FavouriteMoviesSuccess():{
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: GetFavouritesOrWatchListMoviesListViewWidget(
                            movies: state.favouriteMovies,
                            isDummy: false,
                            isFavourite: true,
                        ),
                      ),
                    ],
                  ),
                );
              }
              case FavouriteMoviesFailed():{
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultFailedToLoadWidget(
                          errorMessage: "Failed to get Favourite movies :-(",
                          helpMessage: "please try to restart application"
                      ),
                    ],
                  ),
                );
              }
            }
          }
      ),
    );
  }

  IconButton _getBackFilledIconButton(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        context.pop();
      },
      icon: Icon(Icons.arrow_back_ios_new, color: ColorsManager.whiteColor , size: 20,),
      style: IconButton.styleFrom(
          backgroundColor: ColorsManager.primarySoftColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )
      ),
    );
  }
}
