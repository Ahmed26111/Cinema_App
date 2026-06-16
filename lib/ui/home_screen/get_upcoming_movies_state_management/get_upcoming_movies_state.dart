part of 'get_upcoming_movies_cubit.dart';

@immutable
sealed class GetUpcomingMoviesState {}

final class GetUpcomingMoviesInitial extends GetUpcomingMoviesState {}

final class GetTopRatedMoviesLoading extends GetUpcomingMoviesState {}

final class GetTopRatedMoviesSuccess extends GetUpcomingMoviesState {
  final List<MovieModel> movies;

  GetTopRatedMoviesSuccess({required this.movies});
}

final class GetTopRatedMoviesFailed extends GetUpcomingMoviesState {
  final String message;

  GetTopRatedMoviesFailed({required this.message});
}
