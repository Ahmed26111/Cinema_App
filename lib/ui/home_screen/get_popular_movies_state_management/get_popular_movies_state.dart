part of 'get_popular_movies_cubit.dart';

@immutable
sealed class GetPopularMoviesState {}

final class GetPopularMoviesInitial extends GetPopularMoviesState {}

final class GetPopularMoviesLoading extends GetPopularMoviesState {}

final class GetPopularMoviesSuccess extends GetPopularMoviesState {
  final List<MovieModel> movies;

  GetPopularMoviesSuccess({required this.movies});
}

final class GetPopularMoviesFailed extends GetPopularMoviesState {
  final String message;

  GetPopularMoviesFailed({required this.message});
}
