part of 'favourite_movies_cubit.dart';

@immutable
sealed class FavouriteMoviesState {}

final class FavouriteMoviesInitial extends FavouriteMoviesState {}

final class FavouriteMoviesLoading extends FavouriteMoviesState {}

final class FavouriteMoviesEmpty extends FavouriteMoviesState {}

final class FavouriteMoviesSuccess extends FavouriteMoviesState {
  final List<MovieModel> favouriteMovies;

  FavouriteMoviesSuccess({required this.favouriteMovies});
}

final class FavouriteMoviesFailed extends FavouriteMoviesState {
  final String errorMessage;

  FavouriteMoviesFailed({required this.errorMessage});
}
