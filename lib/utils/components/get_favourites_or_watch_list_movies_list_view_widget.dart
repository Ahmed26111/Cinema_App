import 'package:cinema_app/utils/components/default_favourite_or_watch_list_movie_card_widget.dart';
import 'package:flutter/material.dart';

import '../../data/models/movie/movie_model.dart';

class GetFavouritesOrWatchListMoviesListViewWidget extends StatelessWidget {
  const GetFavouritesOrWatchListMoviesListViewWidget({super.key, required this.movies, this.isLandscape = false, required this.isDummy, required this.isFavourite});

  final List<MovieModel> movies;
  final bool isLandscape;
  final bool isDummy;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) => DefaultFavouriteOrWatchListMovieCardWidget(movieModel: movies[index], isLandscape: isLandscape , isDummy: isDummy, isFavourite: isFavourite,),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
    );
  }
}
