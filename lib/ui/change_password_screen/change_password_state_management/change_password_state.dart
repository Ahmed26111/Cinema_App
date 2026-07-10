part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class OldPasswordValid extends ChangePasswordState {}

final class OldPasswordNotValid extends ChangePasswordState {}

final class NewPasswordEqualConfirmPasswordSuccess extends ChangePasswordState {}

final class NewPasswordEqualConfirmPasswordFailed extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordFailed extends ChangePasswordState {}
