part of 'get_top_rated_movies_cubit.dart';

@immutable
sealed class GetTopRatedMoviesState {}

final class GetTopRatedMoviesInitial extends GetTopRatedMoviesState {}

final class GetTopRatedMoviesLoading extends GetTopRatedMoviesState {}

final class GetTopRatedMoviesSuccess extends GetTopRatedMoviesState {
  final List<MovieModel> movies;

  GetTopRatedMoviesSuccess({required this.movies});
}

final class GetTopRatedMoviesFailed extends GetTopRatedMoviesState {
  final String message;

  GetTopRatedMoviesFailed({required this.message});
}
