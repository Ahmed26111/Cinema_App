import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/shared/conversion.dart';
import 'package:flutter/material.dart';

import '../../constants/api constants/api_constants.dart';

class DefaultListMoviesCardsWidget extends StatefulWidget {
  const DefaultListMoviesCardsWidget({super.key, required this.movies, this.isDummy = false, this.isLandscape = false});

  final List<MovieModel> movies;
  final bool isDummy;
  final bool isLandscape;

  @override
  State<DefaultListMoviesCardsWidget> createState() => _DefaultListMoviesCardsWidgetState();
}

class _DefaultListMoviesCardsWidgetState extends State<DefaultListMoviesCardsWidget> {
  late List<MovieModel> topTenMovies;

  @override
  void initState() {
    topTenMovies = getTopTenShuffleUpComingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context , index) => _getMovieCard(topTenMovies[index] , context),
        separatorBuilder: (context , index) => SizedBox(width: 15,),
        itemCount: topTenMovies.length,
      ),
    );
  }

  Widget _getMovieCard(MovieModel movie, BuildContext context){
    //* Concatenate all genres in one string
    String genresString = movie.genreIds
        ?.map((id) => Conversion.getGenreNameByGenreId(id))
        .join(', ') ?? '';

    return Column(
      children: [
        Container(
          height: 230,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: (widget.isDummy)? AssetImage("images/circular_avatar.png") : NetworkImage(
                    "${ApiConstants.baseImageUrl}${movie.posterPathImage}"),
                fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: _getRateContainer(movie.voteAverage),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: ColorsManager.primarySoftColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12) , bottomRight: Radius.circular(12)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      movie.movieTitle ,
                      style: (widget.isLandscape) ? Theme.of(context).textTheme.labelSmall : Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                  ),
                  Text(
                    genresString,
                    style: (widget.isLandscape) ? Theme.of(context).textTheme.bodySmall : Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getRateContainer(double movieRate) {
    return Padding(
      padding: const EdgeInsets.only(right:  8.0 , top: 8),
      child: Container(
        height: 24,
        width: 56,
        decoration: BoxDecoration(
          color: ColorsManager.primarySoftColorLessOpacity,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rate_rounded , color: ColorsManager.orangeColor,),
              Text(
                movieRate.toStringAsFixed(1),
                style: TextStyle(
                  color: ColorsManager.orangeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<MovieModel> getTopTenShuffleUpComingMovies(){
    List<MovieModel> shuffleMovies = [];
    widget.movies.shuffle();
    final int lengthOfMovies = (widget.movies.length > 10) ? 10 : widget.movies.length;
    for(int i = 0; i < lengthOfMovies;i++){
      shuffleMovies.add(widget.movies[i]);
    }
    return shuffleMovies;
  }

}
