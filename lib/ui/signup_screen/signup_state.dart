part of 'signup_cubit.dart';

@immutable
sealed class SignupState {
  final bool isAcceptTerms;

  const SignupState({required this.isAcceptTerms});
}

final class SignupInitial extends SignupState {
  const SignupInitial({required super.isAcceptTerms});
}

final class AddNewUserSuccessState extends SignupState {
  const AddNewUserSuccessState({required super.isAcceptTerms});
}

final class AddNewUserFailedState extends SignupState {
  const AddNewUserFailedState({required super.isAcceptTerms});
}


