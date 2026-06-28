import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/components/default_movie_rate_container.dart';
import 'package:cinema_app/utils/shared/conversion.dart';
import 'package:flutter/material.dart';

import '../../constants/api constants/api_constants.dart';

class DefaultDetailsMovieCardWidget extends StatelessWidget {
  const DefaultDetailsMovieCardWidget({super.key, required this.movieModel, required this.isLandscape, this.isDummy = false});

  final MovieModel movieModel;
  final bool isLandscape;
  final bool isDummy;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          width: 120,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: (isDummy)
                    ? Image.asset("images/circular_avatar.png", fit: BoxFit.cover, height: 180, width: 120)
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
            children: [
              _getOriginalLanguageButton(context),
              Text(
                movieModel.movieTitle ,
                style: (isLandscape) ? Theme.of(context).textTheme.labelSmall : Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              _getReleaseYearRow(context , isLandscape),
              _getGenreRow(context , isLandscape),
            ],
          ),
        )
      ],
    );
  }

  FilledButton _getOriginalLanguageButton(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
          backgroundColor: ColorsManager.orangeColor,
          fixedSize: Size(80, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          )
      ),
      child: Text(
        movieModel.originalLanguage,
        style: Theme
            .of(context)
            .textTheme
            .labelSmall
            ?.copyWith(fontSize: 12),
      ),
    );
  }

  Row _getReleaseYearRow(BuildContext context , bool isLandscape) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.calendar_month, color: ColorsManager.greyColor,),
        SizedBox(width: 4,),
        Text(movieModel.releaseDate.year.toString(), style: (isLandscape) ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

  Row _getGenreRow(BuildContext context , bool isLandscape) {
    String genresString = movieModel.genreIds
        ?.map((id) => Conversion.getGenreNameByGenreId(id))
        .join(', ') ?? '';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.movie_rounded, color: ColorsManager.greyColor,),
        SizedBox(width: 4,),
        Expanded(
          child: Text(
            genresString,
            style: (isLandscape) ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
