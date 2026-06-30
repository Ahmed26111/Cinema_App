import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/ui/details_movie_screen/details_movie_cubit.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';

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
                    left: ResponsiveSizeConstants.widthScreen(context)*0.19,
                    right:  ResponsiveSizeConstants.widthScreen(context)*0.18,
                    child: Text(
                      movie.movieTitle, style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Positioned(
                  //   top: ResponsiveSizeConstants.heightScreen(context)*0.1375,
                  //   left: ResponsiveSizeConstants.widthScreen(context)*0.2167,
                  //   child: ,
                  // ),
                  // Positioned(
                  //   top: ResponsiveSizeConstants.heightScreen(context)*0.1375,
                  //   left: ResponsiveSizeConstants.widthScreen(context)*0.2167,
                  //   child: ,
                  // ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
