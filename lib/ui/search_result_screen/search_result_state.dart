part of 'search_result_cubit.dart';

@immutable
sealed class SearchResultState {}

final class SearchResultInitial extends SearchResultState {}

final class SearchResultLoading extends SearchResultState {}

final class SearchResultEmpty extends SearchResultState {}

final class SearchResultSuccess extends SearchResultState {
  final List<MovieModel> movies;

  SearchResultSuccess({required this.movies});
}

final class SearchResultFailed extends SearchResultState {
  final String message;

  SearchResultFailed({required this.message});
}

