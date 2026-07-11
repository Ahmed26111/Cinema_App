part of 'cast_cubit.dart';

@immutable
sealed class CastState {}

final class CastInitial extends CastState {}

final class CastLoading extends CastState {}

final class CastEmpty extends CastState {}

final class CastSuccess extends CastState {
  final List<CastModel> casts;

  CastSuccess({required this.casts});
}

final class CastFailed extends CastState {
  final String errorMessage;

  CastFailed({required this.errorMessage});
}
