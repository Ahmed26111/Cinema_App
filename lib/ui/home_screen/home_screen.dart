import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/home_screen/get_popular_movies_state_management/get_popular_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/get_upcoming_movies_state_management/get_upcoming_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/default_genres_buttons_widget.dart';
import 'package:cinema_app/utils/components/default_list_movies_cards_widget.dart';
import 'package:cinema_app/utils/components/default_search_bar_widget.dart';
import 'package:cinema_app/utils/components/upcoming_movies_slider_widget.dart';
import 'package:cinema_app/utils/components/upcoming_movies_slider_widget.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveSizeConstants.widthScreen(context) * 0.08 , vertical: (isLandscape)?0:10),
                child: DefaultSearchBarWidget(controller: searchController, isLandscape: isLandscape),
              ),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.005,),
              BlocBuilder<GetUpcomingMoviesCubit , GetUpcomingMoviesState>(
                  builder: (context ,state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _getMostUpComingRow(context, isLandscape , state),
                        ),
                        SizedBox(height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.035 : ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                        switch(state){
                          GetUpcomingMoviesInitial() => Skeletonizer(
                            containersColor: ColorsManager.greyColor,
                            effect: ShimmerEffect(
                              baseColor: ColorsManager.greyColor,
                              highlightColor: ColorsManager.lineDarkColor,
                            ),
                            enabled: true ,
                            child: UpcomingMoviesSlider(movies: getDummyMovies(6) , isDummy: true, isLandscape: isLandscape)
                        ),
                          GetUpComingMoviesLoading() => Skeletonizer(
                            containersColor: ColorsManager.greyColor,
                            effect: ShimmerEffect(
                              baseColor: ColorsManager.greyColor,
                              highlightColor: ColorsManager.lineDarkColor,
                            ),
                            enabled: true ,
                            child: UpcomingMoviesSlider(movies: getDummyMovies(6) , isDummy: true, isLandscape: isLandscape)
                        ),
                          GetUpComingMoviesSuccess() => UpcomingMoviesSlider(movies: state.movies , isLandscape: isLandscape),
                          GetUpComingMoviesFailed() => DefaultFailedToLoadWidget(
                              errorMessage: "Sorry, Failed to load \nthe Upcoming movies :(",
                              helpMessage: "Please try to connect with internet",
                              isLandscape:isLandscape
                          ),
                        }
                      ],
                    );
                  },
              ),
              BlocBuilder<GetPopularMoviesCubit,GetPopularMoviesState>(
                builder: (context , state){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 14),
                    child: Column(
                      children: [
                        _getCategoriesText(context , isLandscape),
                        SizedBox(height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.035 :ResponsiveSizeConstants.heightScreen(context) * 0.022,),
                        DefaultGenresButtonsWidget(currentMovieGenre: context.read<GetPopularMoviesCubit>().currentMovieGenre , isLandscape: isLandscape,),
                        SizedBox(height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.035 : ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                        _getMostPopularRow(context , isLandscape , state),
                        SizedBox(height: (isLandscape)? ResponsiveSizeConstants.heightScreen(context) * 0.035 : ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                        switch(state){
                         GetPopularMoviesInitial() => Skeletonizer(
                           containersColor: ColorsManager.greyColor,
                           effect: ShimmerEffect(
                             baseColor: ColorsManager.greyColor,
                             highlightColor: ColorsManager.lineDarkColor,
                           ),
                           enabled: true ,
                           child: DefaultListMoviesCardsWidget(movies: getDummyMovies(10) , isDummy: true, isLandscape : isLandscape),
                         ),
                         GetPopularMoviesLoading() => Skeletonizer(
                           containersColor: ColorsManager.greyColor,
                           effect: ShimmerEffect(
                             baseColor: ColorsManager.greyColor,
                             highlightColor: ColorsManager.lineDarkColor,
                           ),
                           enabled: true ,
                           child: DefaultListMoviesCardsWidget(movies: getDummyMovies(10) , isDummy: true, isLandscape : isLandscape),
                         ),
                         GetPopularMoviesSuccess() => DefaultListMoviesCardsWidget(movies: state.movies , isLandscape: isLandscape),
                         GetPopularMoviesFailed()  => DefaultFailedToLoadWidget(
                                 errorMessage: "Sorry, Failed to load \nthe Popular movies :(",
                                 helpMessage: "Please try to connect with internet",
                                 isLandscape: isLandscape
                             ),
                        }
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _getCategoriesText(BuildContext context , bool isLandscape) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Categories",
          style: (isLandscape) ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.displaySmall,
        )
    );
  }

  Row _getMostPopularRow(BuildContext context , bool isLandscape , GetPopularMoviesState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Most popular", style: (isLandscape) ? Theme
            .of(context)
            .textTheme
            .labelMedium : Theme
            .of(context)
            .textTheme
            .displaySmall,),
        TextButton(
            onPressed: (state is GetPopularMoviesSuccess) ? (){
              context.pushNamed(RoutesConstants.defaultSeeAllScreenName , pathParameters: {"appBarTitle" : "Most Popular Movie"} , extra: state.movies);
            } : null,
            child: Text("See All", style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize:
            (isLandscape)
                ? ResponsiveSizeConstants.widthScreen(context) * 0.028
                : ResponsiveSizeConstants.widthScreen(context) * 0.038 ,
              color: (state is GetPopularMoviesSuccess) ? ColorsManager.primaryBlueAccentColor : ColorsManager.transparent,
            ),
            )
        )
      ],
    );
  }

  Row _getMostUpComingRow(BuildContext context , bool isLandscape , GetUpcomingMoviesState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Upcoming", style: (isLandscape) ? Theme
            .of(context)
            .textTheme
            .labelMedium : Theme
            .of(context)
            .textTheme
            .displaySmall,),
        TextButton(
            onPressed: (state is GetUpComingMoviesSuccess)? () {
              context.pushNamed(RoutesConstants.defaultSeeAllScreenName , pathParameters: {"appBarTitle" : "Upcoming Movie"} , extra: state.movies);
            } : null,
            child: Text("See All", style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize:
            (isLandscape)
                ? ResponsiveSizeConstants.widthScreen(context) * 0.028
                : ResponsiveSizeConstants.widthScreen(context) * 0.038 ,
             color:  (state is GetUpComingMoviesSuccess) ? ColorsManager.primaryBlueAccentColor : ColorsManager.transparent,
            ),
            )
        )
      ],
    );
  }

  List<MovieModel> getDummyMovies(int lengthOfDummies){
    return List.generate(lengthOfDummies, (index){
      return MovieModel(
          isAdult: true,
          backdropPathImage: "/c6BPbkO5Npt1OdwttAxCFo06wtH.jpg",
          genreIds: null,
          movieId: 00000,
          movieTitle: "hgcgfhydc",
          originalLanguage: "",
          overview: "",
          posterPathImage: null,
          releaseDate: DateTime.now(),
          voteAverage: 0,
          genres: null,
          imdbId: "",
          runTime: 0,
          status: "",
          tagLine: "",
          originCountry: [],
          productionCompanies: []
      );
    });
  }


}
