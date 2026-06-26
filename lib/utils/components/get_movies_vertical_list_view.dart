import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/components/default_details_movie_card_widget.dart';
import 'package:flutter/material.dart';

class GetMoviesVerticalListView extends StatelessWidget {
  const GetMoviesVerticalListView({super.key, required this.movies, required this.isLandscape, this.isDummy = false});

  final List<MovieModel> movies;
  final bool isLandscape;
  final bool isDummy;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) => DefaultDetailsMovieCardWidget(movieModel: movies[index], isLandscape: isLandscape , isDummy: isDummy,),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
    );
  }
}
