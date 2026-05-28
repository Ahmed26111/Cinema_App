
part of 'create_new_password_cubit.dart';

@immutable
sealed class CreateNewPasswordState {}

final class CreateNewPasswordInitial extends CreateNewPasswordState {}

final class NewPasswordEqualConfirmPasswordSuccess extends CreateNewPasswordState {}

final class NewPasswordEqualConfirmPasswordFailed extends CreateNewPasswordState {}

final class UpdatePasswordSuccess extends CreateNewPasswordState {}

final class UpdatePasswordFailed extends CreateNewPasswordState {}
