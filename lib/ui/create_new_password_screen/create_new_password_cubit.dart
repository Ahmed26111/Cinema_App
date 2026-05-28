import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/repositories/validation_repository.dart';
import 'package:meta/meta.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit() : super(CreateNewPasswordInitial());

  void isNewPasswordEqualToConfirmPassword(String newPassword, String confirmPassword,){
    (newPassword == confirmPassword)
        ? emit(NewPasswordEqualConfirmPasswordSuccess())
        : emit(NewPasswordEqualConfirmPasswordFailed());
  }

  void updateUserPasswordByEmail(String email, String password){
    (!ValidationRepository.updateUserPasswordByEmail(email, password))
        ? emit(UpdatePasswordFailed())
        : emit(UpdatePasswordSuccess());
  }
}
