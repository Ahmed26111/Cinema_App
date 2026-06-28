import 'package:cached_network_image/cached_network_image.dart';
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
        separatorBuilder: (context , index) => const SizedBox(width: 15,),
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
        SizedBox(
          height: 230,
          width: 150,
          child: Stack(
            children: [
              // Use CachedNetworkImage for professional image handling
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), 
                  topRight: Radius.circular(15)
                ),
                child: (widget.isDummy)
                    ? Image.asset("images/circular_avatar.png", fit: BoxFit.cover, height: 230, width: 150)
                    : CachedNetworkImage(
                        imageUrl: "${ApiConstants.baseImageUrl}${movie.posterPathImage}",
                        fit: BoxFit.cover,
                        height: 230,
                        width: 150,
                        placeholder: (context, url) => Container(
                          color: ColorsManager.primarySoftColor,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2 , color: ColorsManager.primaryBlueAccentColor,)),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                            "images/default_poster.png",
                            width: 150,
                            height: 230,
                            fit: BoxFit.cover,
                        ),
                      ),
              ),
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
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12) , bottomRight: Radius.circular(12)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      movie.movieTitle ,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14 , fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                  ),
                  Text(
                    genresString,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10),
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
    List<MovieModel> shuffleMovies = List.from(widget.movies);
    shuffleMovies.shuffle();
    return shuffleMovies.take(10).toList();
  }

}
