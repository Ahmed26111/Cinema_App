part of 'validation_user_cubit.dart';

@immutable
sealed class ValidationUserState {
  final bool isAcceptTerms;

 const ValidationUserState({required this.isAcceptTerms});
}

final class ValidationUserInitial extends ValidationUserState {
  const ValidationUserInitial({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserEmailSuccess extends ValidationUserState {
  const ValidationUserIsUniqueUserEmailSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserEmailFailed extends ValidationUserState {
  const ValidationUserIsUniqueUserEmailFailed({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserIdSuccess extends ValidationUserState {
  const ValidationUserIsUniqueUserIdSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserIdFailed extends ValidationUserState {
  const ValidationUserIsUniqueUserIdFailed({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserAccountExistSuccess extends ValidationUserState {
  const ValidationUserIsUniqueUserAccountExistSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsUniqueUserAccountExistFailed extends ValidationUserState {
  const ValidationUserIsUniqueUserAccountExistFailed({required super.isAcceptTerms});
}

final class ValidationUserToggleIsAcceptTermCondition extends ValidationUserState {
  const ValidationUserToggleIsAcceptTermCondition({required super.isAcceptTerms});
}

final class ValidationUserIsEmailExistsSuccess extends ValidationUserState {
  const ValidationUserIsEmailExistsSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsEmailExistsFailed extends ValidationUserState {
  const ValidationUserIsEmailExistsFailed({required super.isAcceptTerms});
}

final class ValidationUserIsNewPasswordEqualConfirmPasswordSuccess extends ValidationUserState {
  const ValidationUserIsNewPasswordEqualConfirmPasswordSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsNewPasswordEqualConfirmPasswordFailed extends ValidationUserState {
  const ValidationUserIsNewPasswordEqualConfirmPasswordFailed({required super.isAcceptTerms});
}

final class ValidationUserIsUpdatePasswordSuccess extends ValidationUserState {
  const ValidationUserIsUpdatePasswordSuccess({required super.isAcceptTerms});
}

final class ValidationUserIsUpdatePasswordFailed extends ValidationUserState {
  const ValidationUserIsUpdatePasswordFailed({required super.isAcceptTerms});
}
