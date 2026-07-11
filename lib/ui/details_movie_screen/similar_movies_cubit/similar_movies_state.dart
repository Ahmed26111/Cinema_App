part of 'similar_movies_cubit.dart';

@immutable
sealed class SimilarMoviesState {}

final class SimilarMoviesInitial extends SimilarMoviesState {}

final class SimilarMoviesLoading extends SimilarMoviesState {}

final class SimilarMoviesEmpty extends SimilarMoviesState {}

final class SimilarMoviesSuccess extends SimilarMoviesState {
  final List<MovieModel> movies;

  SimilarMoviesSuccess({required this.movies});
}

final class SimilarMoviesFailed extends SimilarMoviesState {
  final String errorMessage;

  SimilarMoviesFailed({required this.errorMessage});
}
