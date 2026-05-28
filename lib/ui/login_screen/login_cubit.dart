import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  void isUserAccountExist(String email , String password){
    List<UserModel> users = HiveHandler.getAllUsers();
    UserModel userModel = Validation.isUserAccountExistInDataBase(email, password, users);
    if(userModel.userId != ""){
      HiveHandler.addAndUpdateActiveUser(userModel);
      emit(UserAccountExistSuccessState());
    }
    else{
      emit(UserAccountExistFailedState());
    }
  }
}
