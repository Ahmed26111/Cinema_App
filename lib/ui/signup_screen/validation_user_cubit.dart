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
      emit(ValidationUserSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserFailed(isAcceptTerms: state.isAcceptTerms));
      return false;
    }
  }

  void toggleAcceptTerms(){
    emit(ValidationUserSuccess(isAcceptTerms: !state.isAcceptTerms));
  }

  bool _isUniqueUserId(String userID){
    List<UserModel> users = HiveHandler.getAllUsers();
    if(Validation.isUniqueUserId(users, userID)){
      emit(ValidationUserSuccess(isAcceptTerms: state.isAcceptTerms));
      return true;
    }
    else{
      emit(ValidationUserFailed(isAcceptTerms: state.isAcceptTerms));
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

}
