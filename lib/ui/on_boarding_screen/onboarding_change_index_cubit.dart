import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_change_index_state.dart';

class OnboardingChangeIndexCubit extends Cubit<OnboardingChangeIndexState> {
  OnboardingChangeIndexCubit() : super(OnboardingChangeIndexInitial(index: 0));

  void changeOnboardingPageIndex(int index) {
    emit(OnboardingChangeIndexSuccess(index: index));
  }
}
