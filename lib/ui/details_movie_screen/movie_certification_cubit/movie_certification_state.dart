part of 'movie_certification_cubit.dart';

@immutable
sealed class MovieCertificationState {}

final class MovieCertificationInitial extends MovieCertificationState {}

final class MovieCertificationLoading extends MovieCertificationState {}

final class MovieCertificationSuccess extends MovieCertificationState {
  final String certification;

  MovieCertificationSuccess({required this.certification});
}

final class MovieCertificationError extends MovieCertificationState {
  final String errorMessage;

  MovieCertificationError({required this.errorMessage});
}
