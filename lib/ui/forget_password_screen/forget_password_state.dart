part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class IsEmailExistsSuccess extends ForgetPasswordState {}

final class IsEmailExistsFailed extends ForgetPasswordState {}
