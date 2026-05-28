part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class UserAccountExistSuccessState extends LoginState {}

final class UserAccountExistFailedState extends LoginState {}
