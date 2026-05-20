import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:meta/meta.dart';

part 'validation_user_state.dart';

class ValidationUserCubit extends Cubit<ValidationUserState> {
  ValidationUserCubit() : super(ValidationUserInitial());

  bool isUniqueUserEmail(String email){
    List<UserModel> users = HiveHandler.getAllUsers();
    if(Validation.isUniqueUserEmail(users, email)){
      emit(ValidationUserSuccess());
      return true;
    }
    else{
      emit(ValidationUserFailed());
      return false;
    }
  }

}
