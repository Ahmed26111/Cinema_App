import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  void _isOldPasswordValid(String oldPassword){
    final UserModel ? activeUser = HiveHandler.getActiveUser();
    if(activeUser != null){
      if(activeUser.password == oldPassword){
        emit(OldPasswordValid());
      }else{
        emit(OldPasswordNotValid());
      }
    }
    else{
      emit(ChangePasswordFailed());
    }
  }
  void _isNewPasswordEqualToConfirmPassword(String newPassword, String confirmPassword,){
    (newPassword == confirmPassword)
        ? emit(NewPasswordEqualConfirmPasswordSuccess())
        : emit(NewPasswordEqualConfirmPasswordFailed());
  }
  void changeUserPassword(String oldPassword , String newPassword , String confirmPassword){
    _isOldPasswordValid(oldPassword);
    if(state is OldPasswordValid){
      _isNewPasswordEqualToConfirmPassword(newPassword, confirmPassword);
      if(state is NewPasswordEqualConfirmPasswordSuccess){
        final UserModel ? activeUser = HiveHandler.getActiveUser();
        final UserModel newActiveUser = activeUser?.copyWith(password: newPassword) ?? UserModel.placeHolder();
        if(newActiveUser.userId != ""){
          HiveHandler.addAndUpdateActiveUser(newActiveUser);
          HiveHandler.addAndUpdateUsers(newActiveUser);
          emit(ChangePasswordSuccess());
        }
        else{
          emit(ChangePasswordFailed());
        }
      }
    }
  }
}
