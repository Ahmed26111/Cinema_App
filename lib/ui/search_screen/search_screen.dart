import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/ui/home_screen/get_top_rated_movies_state_management/get_top_rated_movies_cubit.dart';
import 'package:cinema_app/utils/components/default_details_movie_card_widget.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/default_genres_buttons_widget.dart';
import 'package:cinema_app/utils/components/default_search_bar_widget.dart';
import 'package:cinema_app/utils/components/get_movies_vertical_list_view.dart';
import 'package:cinema_app/utils/shared/getDummyMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetTopRatedMoviesCubit , GetTopRatedMoviesState>(
          builder: (context , state) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 14),
                  child: Column(
                    children: [
                      DefaultSearchBarWidget(controller: _searchController, hintText: "Type title, categories, years, etc"),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.03,),
                      DefaultGenresButtonsWidget(
                        currentMovieGenre: context.read<GetTopRatedMoviesCubit>().currentMovieGenre,
                        onTapButton: (genre) => context.read<GetTopRatedMoviesCubit>().changeCurrentMovieGenre(genre),
                      ),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.03,),
                      switch(state){
                        GetTopRatedMoviesInitial() || GetTopRatedMoviesLoading()  =>
                            Expanded(
                              child: Skeletonizer(
                                containersColor: ColorsManager.greyColor,
                                effect: ShimmerEffect(
                                  baseColor: ColorsManager.greyColor,
                                  highlightColor: ColorsManager.lineDarkColor,
                                ),
                                enabled: true,
                                child: GetMoviesVerticalListView(
                                  movies: getDummyMovies(10),
                                  isDummy: true,
                                ),
                              ),
                            ),
                        GetTopRatedMoviesSuccess() => Expanded(child: GetMoviesVerticalListView(movies: state.movies)),
                        GetTopRatedMoviesFailed() => DefaultFailedToLoadWidget(
                            errorMessage: "Sorry, Failed to load \nthe Top Rated movies :(",
                            helpMessage: "Please try to connect with internet",
                        ),
                      }
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
