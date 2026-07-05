part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetActiveUserLoading extends ProfileState {}

final class GetActiveUserSuccessfully extends ProfileState {
  final UserModel activeUser;

  GetActiveUserSuccessfully({required this.activeUser});
}

final class GetActiveUserFailed extends ProfileState {
  final String errorMessage;

  GetActiveUserFailed({required this.errorMessage});

}
