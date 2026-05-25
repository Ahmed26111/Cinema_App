import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

part 'validation_user_state.dart';

class ValidationUserCubit extends Cubit<ValidationUserState> {
  ValidationUserCubit() : super(ValidationUserInitial(isAcceptTerms: false));

  bool isUniqueUserEmail(String email){
    List<UserModel> users = HiveHandler.getAllUsers();
    if(Validation.isUniqueUserEmail(users, email)){
      emit(ValidationUserIsUniqueUserEmailSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserIsUniqueUserEmailFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

  void toggleAcceptTerms(){
    emit(ValidationUserToggleIsAcceptTermCondition(isAcceptTerms: !state.isAcceptTerms));
  }

  bool _isUniqueUserId(String userID){
    List<UserModel> users = HiveHandler.getAllUsers();
    if(Validation.isUniqueUserId(users, userID)){
      emit(ValidationUserIsUniqueUserIdSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserIsUniqueUserIdFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

  bool addNewUser(String firstName , String lastName , String email , String password){
    if(isUniqueUserEmail(email)){
      String userId = Uuid().v4();
      while(! _isUniqueUserId(userId)){
        userId = Uuid().v4();
      }
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          userId: userId,
          favouritesMoviesIds: <int>[],
          watchListMoviesIds: <int>[],
          tickets: <TicketModel>[]
      );
      HiveHandler.addAndUpdateUsers(userModel);
      HiveHandler.addAndUpdateActiveUser(userModel);
      return true;
    }
    return false;
  }

  bool isUserAccountExist(String email , String password){
      List<UserModel> users = HiveHandler.getAllUsers();
      UserModel userModel = Validation.isUserAccountExistInDataBase(email, password, users);
      if(userModel.userId != ""){
        emit(ValidationUserIsUniqueUserAccountExistSuccess(isAcceptTerms: state.isAcceptTerms));
        HiveHandler.addAndUpdateActiveUser(userModel);
        return true;
      }
      else{
        emit(ValidationUserIsUniqueUserAccountExistFailed(isAcceptTerms: state.isAcceptTerms));
        return false;
      }
  }

  bool isEmailExistsForUpdatePassword(String email){
    if(! isUniqueUserEmail(email)){
      emit(ValidationUserIsEmailExistsSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserIsEmailExistsFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

  bool isNewPasswordEqualToConfirmPassword(String newPassword , String confirmPassword){
    if(newPassword == confirmPassword){
      emit(ValidationUserIsNewPasswordEqualConfirmPasswordSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }else{
      emit(ValidationUserIsNewPasswordEqualConfirmPasswordFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

  bool updateUserPasswordByEmail(String email , String password){
    List<UserModel> users = HiveHandler.getAllUsers();
    UserModel user =  users.firstWhere((user)=>(user.email == email) , orElse: UserModel.placeHolder);
    if(user.userId != ""){
      user = user.copyWith(password: password);
      HiveHandler.addAndUpdateUsers(user);
      emit(ValidationUserIsUpdatePasswordSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserIsUpdatePasswordFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

}
