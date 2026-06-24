import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/components/default_movie_rate_container.dart';
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0 , right: 8.0),
                  child: DefaultMovieRateContainer(movieRate: movie.voteAverage,),
                ),
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
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14 , fontWeight: FontWeight.bold),//? make it fixed size
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                  ),
                  Text(
                    genresString,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10),//? make it fixed size
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
