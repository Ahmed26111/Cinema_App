part of 'validation_user_cubit.dart';

@immutable
sealed class ValidationUserState {}

final class ValidationUserInitial extends ValidationUserState {}

final class ValidationUserSuccess extends ValidationUserState {}

final class ValidationUserFailed extends ValidationUserState {}
