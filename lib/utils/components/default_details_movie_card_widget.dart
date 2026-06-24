import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/components/default_movie_rate_container.dart';
import 'package:cinema_app/utils/shared/conversion.dart';
import 'package:flutter/material.dart';

import '../../constants/api constants/api_constants.dart';

class DefaultDetailsMovieCardWidget extends StatelessWidget {
  const DefaultDetailsMovieCardWidget({super.key, required this.movieModel, required this.isLandscape});

  final MovieModel movieModel;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("${ApiConstants.baseImageUrl}${movieModel.posterPathImage}")
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
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
              _getIsAdultOrFamilyButton(context),
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

  FilledButton _getIsAdultOrFamilyButton(BuildContext context) {
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
        (movieModel.isAdult) ? "Adult" : "Family",
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
