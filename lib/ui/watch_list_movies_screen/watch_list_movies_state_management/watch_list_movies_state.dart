part of 'watch_list_movies_cubit.dart';

@immutable
sealed class WatchListMoviesState {}

final class WatchListMoviesInitial extends WatchListMoviesState {}

final class WatchListMoviesLoading extends WatchListMoviesState {}

final class WatchListMoviesEmpty extends WatchListMoviesState {}

final class WatchListMoviesSuccess extends WatchListMoviesState {
  final List<MovieModel> watchListMovies;

  WatchListMoviesSuccess({required this.watchListMovies});
}

final class WatchListMoviesFailed extends WatchListMoviesState {
  final String errorMessage;

  WatchListMoviesFailed({required this.errorMessage});
}
