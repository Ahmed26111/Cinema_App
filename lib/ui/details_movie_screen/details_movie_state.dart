part of 'details_movie_cubit.dart';

@immutable
sealed class DetailsMovieState {}

final class DetailsMovieInitial extends DetailsMovieState {}

final class DetailsMovieLoading extends DetailsMovieState {}

final class DetailsMovieSuccess extends DetailsMovieState {
  final MovieModel movie;
  final bool isFavourite;
  final bool isWatchList;

  DetailsMovieSuccess({required this.movie , required this.isFavourite , required this.isWatchList});
}

final class DetailsMovieFailed extends DetailsMovieState {
  final String errorMessage;

  DetailsMovieFailed({required this.errorMessage});
}

