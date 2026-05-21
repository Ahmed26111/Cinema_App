part of 'validation_user_cubit.dart';

@immutable
sealed class ValidationUserState {
  final bool isAcceptTerms;

 const ValidationUserState({required this.isAcceptTerms});
}

final class ValidationUserInitial extends ValidationUserState {
  const ValidationUserInitial({required super.isAcceptTerms});
}

final class ValidationUserSuccess extends ValidationUserState {
  const ValidationUserSuccess({required super.isAcceptTerms});
}

final class ValidationUserFailed extends ValidationUserState {
  const ValidationUserFailed({required super.isAcceptTerms});
}
