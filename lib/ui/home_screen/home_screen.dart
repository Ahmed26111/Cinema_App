import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/ui/home_screen/get_upcoming_movies_state_management/get_upcoming_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/default_search_bar_widget.dart';
import 'package:cinema_app/utils/components/upcoming_movies_slider_widget.dart';
import 'package:cinema_app/utils/components/upcoming_movies_slider_widget.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
              BlocBuilder<GetUpcomingMoviesCubit , GetUpcomingMoviesState>(
                  builder: (context ,state) {
                    switch(state){
                      case GetUpcomingMoviesInitial():
                      case GetUpComingMoviesLoading(): {
                        return Skeletonizer(
                            containersColor: ColorsManager.greyColor,
                            effect: ShimmerEffect(
                              baseColor: ColorsManager.greyColor,
                              highlightColor: ColorsManager.lineDarkColor,
                            ),
                            enabled: true ,
                            child: UpcomingMoviesSlider(movies: getDummyUpComingMovies() , isDummy: true, isLandscape: isLandscape)
                        );
                      }
                      case GetUpComingMoviesSuccess():{
                        return UpcomingMoviesSlider(movies: state.movies , isLandscape: isLandscape);
                      }
                      case GetUpComingMoviesFailed():{
                        return DefaultFailedToLoadWidget(
                            errorMessage: "Sorry, Failed to load \nthe Upcoming movies :(",
                            helpMessage: "Please try to connect with internet",
                            isLandscape:isLandscape
                        );
                      }
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<MovieModel> getDummyUpComingMovies(){
    return List.generate(6, (index){
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
