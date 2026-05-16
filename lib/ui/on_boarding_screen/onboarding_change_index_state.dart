part of 'onboarding_change_index_cubit.dart';

@immutable
sealed class OnboardingChangeIndexState {
  final int index;

  const OnboardingChangeIndexState({required this.index});
}

final class OnboardingChangeIndexInitial extends OnboardingChangeIndexState {
  const OnboardingChangeIndexInitial({required super.index});
}

final class OnboardingChangeIndexSuccess extends OnboardingChangeIndexState {
  const OnboardingChangeIndexSuccess({required super.index});
}
