part of 'get_top_rated_movies_cubit.dart';

@immutable
sealed class GetTopRatedMoviesState {}

final class GetTopRatedMoviesInitial extends GetTopRatedMoviesState {}

final class GetUpComingMoviesLoading extends GetTopRatedMoviesState {}

final class GetUpComingMoviesSuccess extends GetTopRatedMoviesState {
  final List<MovieModel> movies;

  GetUpComingMoviesSuccess({required this.movies});
}

final class GetUpComingMoviesFailed extends GetTopRatedMoviesState {
  final String message;

  GetUpComingMoviesFailed({required this.message});
}
