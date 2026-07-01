import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/cast_model.dart';
import 'package:cinema_app/data/models/company_model.dart';
import 'package:cinema_app/data/models/genre_model.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/ui/details_movie_screen/cast_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/details_movie_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/movie_certification_cubit.dart';
import 'package:cinema_app/ui/details_movie_screen/similar_movies_cubit.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/default_list_movies_cards_widget.dart';
import 'package:cinema_app/utils/components/default_movie_rate_container.dart';
import 'package:cinema_app/utils/shared/getDummyMovies.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/routes constants/routes_constants.dart';

class DetailsMovieScreen extends StatelessWidget {
  const DetailsMovieScreen({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = ResponsiveSizeConstants.isLandscape(context);

    return BlocBuilder<DetailsMovieCubit, DetailsMovieState>(
      builder: (context, state) {
        switch(state){
          case DetailsMovieInitial() || DetailsMovieLoading():{
            return _getLoadingScaffold(context);
          }
          case DetailsMovieSuccess():{
             return _getMovieDetailsSuccess(context, state.movie , state.isFavourite , state.isWatchList);
          }
          case DetailsMovieFailed():{
            return _getFailedToLoadDetailsMovie(context , isLandscape);
          }
        }
      },
    );
  }

  Widget _getLoadingScaffold(BuildContext context) {
    return Skeletonizer(
      containersColor: ColorsManager.greyColor,
      effect: ShimmerEffect(
        baseColor: ColorsManager.greyColor,
        highlightColor: ColorsManager.lineDarkColor,
      ),
      enabled: true ,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          leading: _getBackFilledIconButton(context),
        ),
        body: Image.asset(
          "images/onboarding_1.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  Scaffold _getFailedToLoadDetailsMovie(BuildContext context , bool isLandscape){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _getBackFilledIconButton(context),
        leadingWidth: 80,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.3,),
            DefaultFailedToLoadWidget(
              errorMessage: "Sorry, Failed to load movie details :(",
              helpMessage: "Please try to connect with internet",
              isLandscape: isLandscape,
            ),
          ],
        ),
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

  Scaffold _getMovieDetailsSuccess(BuildContext context , MovieModel movie , bool isFavourite , bool isWatchList){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.transparent,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.transparent,
        ),
        leading: _getBackFilledIconButton(context),
        leadingWidth: 80,
        title: Text(
          movie.movieTitle,
          style: Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              context.read<DetailsMovieCubit>().toggleFavouriteMovie();
            },
            icon: Icon(
              (isFavourite)? Icons.favorite_outlined : Icons.favorite_outline,
              color: (isFavourite)? ColorsManager.redColor : ColorsManager.lineDarkColor,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: ColorsManager.primarySoftColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 10),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorsManager.primarySoftColorLessOpacityLinearGradientStart,
                          ColorsManager.primarySoftColorLessOpacityLinearGradientEnd,
                        ],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstATop,
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConstants.baseImageUrl}${movie
                          .posterPathImage}',
                      width: double.infinity,
                      height: 550,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(
                            color: ColorsManager.primarySoftColor,
                            child: Center(child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorsManager.primaryBlueAccentColor,)),
                          ),
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            "images/default_poster.png",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  Positioned(
                    top: ResponsiveSizeConstants.heightScreen(context)*0.1375,
                    left: ResponsiveSizeConstants.widthScreen(context)*0.2167,
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConstants.baseImageUrl}${movie
                          .posterPathImage}',
                      width: 206,
                      height: 288,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(
                            color: ColorsManager.primarySoftColor,
                            child: Center(child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorsManager.primaryBlueAccentColor,)),
                          ),
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            "images/default_poster.png",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  Positioned(
                    top: ResponsiveSizeConstants.heightScreen(context)*0.51,
                    left: ResponsiveSizeConstants.widthScreen(context)*0.13,
                    right:  ResponsiveSizeConstants.widthScreen(context)*0.13,
                    child: Column(
                      children: [
                        Text(
                          movie.movieTitle, style: Theme.of(context).textTheme.labelLarge,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ), //? to make the row balanced in the center with the last _getIconAndTextDescriptionOfTheMovie element
                            ..._getIconAndTextDescriptionOfTheMovie(context , Icons.calendar_today_rounded , movie.releaseDate.year.toString()),
                            ..._getSeparatorWidget(context),
                            ..._getIconAndTextDescriptionOfTheMovie(context , Icons.access_time_filled_rounded , "${movie.runTime} Minutes"),
                            ..._getSeparatorWidget(context),
                            ..._getIconAndTextDescriptionOfTheMovie(context , Icons.local_movies_rounded , movie.genres?[0].name ?? "" , true),
                          ],
                        ),
                        SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.014,),
                        DefaultMovieRateContainer(movieRate: movie.voteAverage),
                        SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if( (DateTime.now().difference(movie.releaseDate).compareTo(Duration(days: 90)) <= 0 &&  DateTime.now().compareTo(movie.releaseDate) >= 0)
                    ||(DateTime.now().difference(movie.releaseDate).compareTo(Duration(days: 12)) <= 0  && DateTime.now().compareTo(movie.releaseDate) <= 0)
                  )
                  ...[
                    FilledButton.icon(
                      onPressed: (){
                        // TODO push to tickets screen
                      },
                      label: Text("Buy Tickets") ,
                      icon: Icon(Icons.local_movies_sharp),
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorsManager.primaryBlueAccentColor,
                        foregroundColor: ColorsManager.whiteColor,
                        textStyle: Theme.of(context).textTheme.labelMedium,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                  ],
                  IconButton.filled(
                      onPressed: (){
                        context.read<DetailsMovieCubit>().toggleFavouriteMovie();
                      },
                      icon: Icon(
                          (isFavourite)? Icons.favorite_outlined : Icons.favorite_outline,
                          color: (isFavourite)? ColorsManager.redColor : ColorsManager.lineDarkColor,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: ColorsManager.primarySoftColor,
                        iconSize: 20
                      ),
                  ),
                  SizedBox(width: 8,),
                  IconButton.filled(
                    onPressed: () {
                      context.read<DetailsMovieCubit>().toggleWatchListMovie();
                    },
                    icon: Icon(
                        (isWatchList) ? Icons.bookmark : Icons.bookmark_border,
                        color: (isWatchList) ? ColorsManager.orangeColor : ColorsManager.lineDarkColor,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: ColorsManager.primarySoftColor,
                        iconSize: 20
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._getStoryLine(context, movie.overview),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.02,),
                    _getReleaseDate(context, movie.releaseDate),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.02,),
                    _getGenres(context, movie.genres),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.02,),
                    BlocBuilder<MovieCertificationCubit, MovieCertificationState>(
                      builder: (context, state) {
                        switch(state){
                          case MovieCertificationInitial() || MovieCertificationLoading():{
                            return CircularProgressIndicator(color: ColorsManager.primaryBlueAccentColor, strokeWidth: 2,);
                          }
                          case MovieCertificationSuccess():{
                            return _getIsAdultMovie(context, state.certification);
                          }
                          case MovieCertificationError():{
                            return Text(
                              "Failed to load movie certification\nplease try to connect with internet",
                              style: Theme.of(context).textTheme.labelMedium,
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.02,),
                    _getOriginalCountry(context , movie.originCountry),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.028,),
                    _getProductionCompanies(context, movie.productionCompanies),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.028,),
                    BlocBuilder<CastCubit , CastState>(
                        builder: (context , state){
                          switch(state){
                            case CastInitial() || CastLoading():{
                              return Skeletonizer(
                                containersColor: ColorsManager.greyColor,
                                effect: ShimmerEffect(
                                  baseColor: ColorsManager.greyColor,
                                  highlightColor: ColorsManager.lineDarkColor,
                                ),
                                enabled: true ,
                                child: _getCastAndCrew(context, _getDummyCasts(10)),
                              );
                            }
                            case CastSuccess():{
                              return _getCastAndCrew(context, state.casts);
                            }
                            case CastFailed():{
                              return DefaultFailedToLoadWidget(
                                errorMessage: "Sorry, Failed to load casts :(",
                                helpMessage: "Please try to connect with internet",
                              );
                            }
                          }
                        }
                    ),
                    BlocBuilder<SimilarMoviesCubit , SimilarMoviesState>(
                     builder: (context , state){
                       switch(state){
                         case SimilarMoviesInitial() || SimilarMoviesLoading():{
                           return Skeletonizer(
                             containersColor: ColorsManager.greyColor,
                             effect: ShimmerEffect(
                               baseColor: ColorsManager.greyColor,
                               highlightColor: ColorsManager.lineDarkColor,
                             ),
                             enabled: true ,
                               child: _getSimilarMovies(context,getDummyMovies(10),state,true),
                           );
                         }
                         case SimilarMoviesSuccess():{
                           return _getSimilarMovies(context,state.movies,state,false);
                         }
                         case SimilarMoviesFailed():{
                           return DefaultFailedToLoadWidget(
                             errorMessage: "Sorry, Failed to load similar movies :(",
                             helpMessage: "Please try to connect with internet",
                           );
                         }
                       }
                     },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getIconAndTextDescriptionOfTheMovie(BuildContext context , IconData iconData , String textData , [bool isLastElement = false]){
    return <Widget>[
      Icon(iconData , color: ColorsManager.greyColor, size: 16,),
      SizedBox(width: 4,),
      (isLastElement)
      ? Expanded(flex: 4, child: Text(textData, style: Theme.of(context).textTheme.titleSmall))
      : Text(textData, style: Theme.of(context).textTheme.titleSmall),
    ];
  }

  List<Widget> _getSeparatorWidget(BuildContext context) {
    return <Widget>[
      SizedBox(width: 12,),
      Text("|", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 16),),
      SizedBox(width: 12,),
    ];
  }

  List<Widget> _getStoryLine(BuildContext context , String overView){
    return <Widget>[
      Text("Story Line" , style: Theme.of(context).textTheme.displaySmall),
      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
      Text(overView , style: Theme.of(context).textTheme.titleSmall,),
    ];
  }

  Row _getReleaseDate(BuildContext context , DateTime releaseDate){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Release Date : " , style: Theme.of(context).textTheme.labelMedium),
        SizedBox(width: 5,),
        Text(formatDate(releaseDate, ["on ", MM , " ", d , " , " , yyyy]) , style: Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

  Row _getGenres(BuildContext context , List<GenreModel>? genres){
    final String movieGenres = genres?.map((genre)=>genre.name).join(", ") ?? ""; //? concatenate the movie genres in one string
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Genres : " , style: Theme.of(context).textTheme.labelMedium),
        SizedBox(width: 5,),
        Text(movieGenres, style: Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

  Row _getIsAdultMovie(BuildContext context , String movieCertification){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Movie age rating : " , style: Theme.of(context).textTheme.labelMedium),
        SizedBox(width: 5,),
        Text( movieCertification , style: Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

  Row _getOriginalCountry(BuildContext context , List<String>? originalCountry){
    final String movieOriginalCountry = originalCountry?.map((genre)=>genre).join(", ") ?? ""; //? concatenate the movie genres in one string
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Original Country : " , style: Theme.of(context).textTheme.labelMedium),
        SizedBox(width: 5,),
        Text(movieOriginalCountry, style: Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

  Column _getCastAndCrew(BuildContext context , List<CastModel> casts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text("Cast and Crew" , style: Theme.of(context).textTheme.displaySmall),
        SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.027,),
        SizedBox(
          height: 130,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index)=>SizedBox(
              height: 130,
              width: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: "${ApiConstants.baseImageUrl}${casts[index].profileImagePath}",
                    height: 100,
                    width: 80,
                    placeholder: (context, url) =>
                        Container(
                          color: ColorsManager.primarySoftColor,
                          child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorsManager.primaryBlueAccentColor,
                              )
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Image.asset(
                          (casts[index].gender == 0)
                              ? "images/default_male_avatar.png"
                              : "images/default_female_avatar.png",
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(casts[index].name , style: Theme.of(context).textTheme.labelMedium,overflow: TextOverflow.ellipsis,maxLines: 3,),
                        Text(casts[index].characterName , style: Theme.of(context).textTheme.titleSmall,overflow: TextOverflow.ellipsis,maxLines: 3,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 8,),
            itemCount: casts.length,
          ),
        )
      ]
    );
  }

  Column _getProductionCompanies(BuildContext context , List<CompanyModel> ? companies) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text("Production Company" , style: Theme.of(context).textTheme.displaySmall),
          SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.027,),
          SizedBox(
            height: 80,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index)=>SizedBox(
                height: 80,
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${ApiConstants.baseImageUrl}${companies?[index].logoImagePath}",
                      height: 80,
                      width: 80,
                      placeholder: (context, url) =>
                          Container(
                            color: ColorsManager.primarySoftColor,
                            child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ColorsManager.primaryBlueAccentColor,
                                )
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            "images/default_company_logo.png",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(companies?[index].companyName??"unknown company" , style: Theme.of(context).textTheme.labelMedium,overflow: TextOverflow.ellipsis,maxLines: 3,),
                          Text(companies?[index].originCountry??"unknown origin country" , style: Theme.of(context).textTheme.titleSmall,overflow: TextOverflow.ellipsis,maxLines: 3,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 10,),
              itemCount: companies?.length ?? 0,
            ),
          )
        ]
    );
  }

  List<CastModel> _getDummyCasts(int lengthOfCasts) {
    return List.generate(lengthOfCasts, (index) =>
        CastModel(
            gender: 0,
            castId: 0,
            name: "name",
            characterName: "characterName",
            profileImagePath: "images/default_male_avatar.png",
            orderInList: index,
        ),
    );
  }

  Column _getSimilarMovies(BuildContext context , List<MovieModel> movies , SimilarMoviesState state , bool isDummy){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Similar Movies", style: Theme.of(context).textTheme.displaySmall,),
            TextButton(
                onPressed: (state is SimilarMoviesSuccess) ? (){
                  context.pushNamed(RoutesConstants.defaultSeeAllScreenName , pathParameters: {"appBarTitle" : "Similar Movie"} , extra: state.movies);
                } : null,
                child: Text("See All", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.038 ,
                  color: (state is SimilarMoviesSuccess) ? ColorsManager.primaryBlueAccentColor : ColorsManager.transparent,
                ),
                )
            )
          ],
        ),
        SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
        DefaultListMoviesCardsWidget(movies: movies , isDummy: isDummy,),
      ],
    );
  }
}
