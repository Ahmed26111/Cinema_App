import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app/ui/favourite_movies_screen/favourite_movies_state_management/favourite_movies_cubit.dart';
import 'package:cinema_app/ui/watch_list_movies_screen/watch_list_movies_state_management/watch_list_movies_cubit.dart';
import 'package:cinema_app/utils/components/default_movie_rate_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/api constants/api_constants.dart';
import '../../constants/color constants/colors_manager.dart';
import '../../constants/routes constants/routes_constants.dart';
import '../../data/models/movie/movie_model.dart';

class DefaultFavouriteOrWatchListMovieCardWidget extends StatelessWidget {
  const DefaultFavouriteOrWatchListMovieCardWidget({super.key, required this.movieModel, required this.isLandscape, required this.isDummy, required this.isFavourite});

  final MovieModel movieModel;
  final bool isLandscape;
  final bool isDummy;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(RoutesConstants.detailsMovieScreenName , pathParameters: {"movieId" : movieModel.movieId.toString()});
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            width: 120,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: (isDummy)
                      ? Image.asset("images/default_male_avatar.png", fit: BoxFit.cover, height: 180, width: 120)
                      : CachedNetworkImage(
                    imageUrl: "${ApiConstants.baseImageUrl}${movieModel.posterPathImage}",
                    fit: BoxFit.cover,
                    height: 180,
                    width: 120,
                    placeholder: (context, url) => Container(
                      color: ColorsManager.primarySoftColor,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: ColorsManager.primaryBlueAccentColor,)),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "images/default_poster.png",
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0 , left: 8.0),
                    child: DefaultMovieRateContainer(movieRate: movieModel.voteAverage,),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              spacing: 14,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  movieModel.movieTitle ,
                  style: (isLandscape) ? Theme.of(context).textTheme.labelSmall : Theme.of(context).textTheme.labelLarge,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                _getGenreRow(context , isLandscape),
              ],
            ),
          ),
          SizedBox(width: 16,),
          IconButton(
              onPressed: (){
                if(isFavourite){
                  context.read<FavouriteMoviesCubit>().removeMovieFromFavourites(movieModel);
                }
                else{
                  context.read<WatchListMoviesCubit>().removeMovieFromWatchLists(movieModel);
                }
              },
              icon: Icon(Icons.remove_circle_outline),
              color:  ColorsManager.redColor,
              iconSize: 25,
          ),
        ],
      ),
    );
  }
  Row _getGenreRow(BuildContext context , bool isLandscape) {
    String genreString = movieModel.genres?[0].name ?? "";

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.movie_rounded, color: ColorsManager.greyColor,),
        SizedBox(width: 4,),
        Expanded(
          child: Text(
            genreString,
            style: (isLandscape) ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
