import 'dart:developer';

import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/movie%20genre%20enum/movie_genre_enum.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/home_screen/get_popular_movies_state_management/get_popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultGenresButtonsWidget extends StatelessWidget {
  const DefaultGenresButtonsWidget({super.key, required this.currentMovieGenre, this.isLandscape = false, required this.onTapButton});

   final MovieGenreEnum currentMovieGenre;
   final bool isLandscape;
   final void Function(MovieGenreEnum genre) onTapButton;

   final List<MovieGenreEnum> topSevenGenres = const <MovieGenreEnum>[
     MovieGenreEnum.All,
     MovieGenreEnum.Action,
     MovieGenreEnum.Comedy,
     MovieGenreEnum.Crime,
     MovieGenreEnum.Horror,
     MovieGenreEnum.Drama,
     MovieGenreEnum.Family,
     MovieGenreEnum.Fantasy,
   ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: topSevenGenres.length,
          itemBuilder: (context , index)=>_getGenreBoxContainer(topSevenGenres[index], context),
          separatorBuilder: (context , index)=>SizedBox(width: 8,),
      ),
    );
  }

  Widget _getGenreBoxContainer(MovieGenreEnum movieGenre , BuildContext context){
    return GestureDetector(
      onTap: (){
        if(currentMovieGenre.genreID != movieGenre.genreID){
          onTapButton.call(movieGenre);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: ResponsiveSizeConstants.widthScreen(context) * 0.2,
        height: ResponsiveSizeConstants.widthScreen(context) * 0.05,
        constraints: BoxConstraints(
          minWidth: 70,
          minHeight: 40,
          maxWidth: 90,
          maxHeight: 50,
        ),
        decoration: BoxDecoration(
          color: (movieGenre.genreID == currentMovieGenre.genreID)
              ? ColorsManager.primarySoftColor
              : ColorsManager.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            movieGenre.name,
            style: (movieGenre.genreID == currentMovieGenre.genreID)
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: (isLandscape)? ResponsiveSizeConstants.widthScreen(context) * 0.025 : ResponsiveSizeConstants.widthScreen(context) * 0.045
                )
                : (isLandscape)? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }

}
