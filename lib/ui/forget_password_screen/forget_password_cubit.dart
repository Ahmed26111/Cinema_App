import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/repositories/validation_repository.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  void isEmailExists(String email) {
    (!ValidationRepository.isUniqueUserEmail(email))
        ? emit(IsEmailExistsSuccess())
        : emit(IsEmailExistsFailed());
  }
}
