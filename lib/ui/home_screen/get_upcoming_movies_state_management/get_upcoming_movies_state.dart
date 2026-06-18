part of 'get_upcoming_movies_cubit.dart';

@immutable
sealed class GetUpcomingMoviesState {}

final class GetUpcomingMoviesInitial extends GetUpcomingMoviesState {}


final class GetUpComingMoviesLoading extends GetUpcomingMoviesState {}

final class GetUpComingMoviesSuccess extends GetUpcomingMoviesState {
  final List<MovieModel> movies;

  GetUpComingMoviesSuccess({required this.movies});
}

final class GetUpComingMoviesFailed extends GetUpcomingMoviesState {
  final String message;

  GetUpComingMoviesFailed({required this.message});
}
