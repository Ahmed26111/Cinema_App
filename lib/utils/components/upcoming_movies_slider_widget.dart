import 'dart:async';

import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class UpcomingMoviesSlider extends StatefulWidget {
  const UpcomingMoviesSlider({super.key, required this.movies, this.isDummy = false});
  final List<MovieModel> movies;
  final bool isDummy;
  @override
  State<UpcomingMoviesSlider> createState() => _UpcomingMoviesSliderState();
}

class _UpcomingMoviesSliderState extends State<UpcomingMoviesSlider> {
  int _currentPage = 0;
  late PageController _pageController;
  late List<MovieModel> shuffleMovies;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // view only 6 random movies
    shuffleMovies = getTopSixShuffleUpComingMovies();
    // viewportFraction 0.9 allows seeing a bit of the next/previous cards
    _pageController = PageController(viewportFraction: 0.8);

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % shuffleMovies.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getMovieImageSlider(),
        const SizedBox(height: 12),
        // Custom Pill Indicators
        getCustomIndicator(),
      ],
    );
  }

  Row getCustomIndicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          // Display dots (limited to 5 or 6 for UI neatness)
          shuffleMovies.length > 6 ? 6 : shuffleMovies.length,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: _currentPage == index ? 24 : 8, // Pill shape for active
            decoration: BoxDecoration(
              color: _currentPage == index
                  ? ColorsManager.primaryBlueAccentColor
                  : ColorsManager.primarySoftColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
  }

  SizedBox getMovieImageSlider() {
    return SizedBox(
        height: 200, // Height of the slider
        child: PageView.builder(
          controller: _pageController,
          itemCount: shuffleMovies.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final movie = shuffleMovies[index];
            return getUpComingMovieContainer(movie, context);
          },
        ),
      );
  }

  Container getUpComingMovieContainer(MovieModel movie, BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: (!widget.isDummy)?NetworkImage(
                  "${ApiConstants.baseImageUrl}${movie.backdropPathImage}",
                ):AssetImage("images/Onboarding_2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Text(
                    movie.movieTitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Text(
                    "On ${formatDate(movie.releaseDate, [M , " " ,dd , " , " , yyyy])}",
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
  }

  List<MovieModel> getTopSixShuffleUpComingMovies(){
    List<MovieModel> shuffleMovies = [];
    widget.movies.shuffle();
    final int lengthOfMovies = (widget.movies.length > 6) ? 6 : widget.movies.length;
    for(int i = 0; i < lengthOfMovies;i++){
      shuffleMovies.add(widget.movies[i]);
    }
    return shuffleMovies;
  }

}