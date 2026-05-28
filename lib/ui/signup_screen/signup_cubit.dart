import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/data/repositories/validation_repository.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial(isAcceptTerms: false));

  void toggleAcceptTerms(){
    emit(SignupInitial(isAcceptTerms: ! state.isAcceptTerms));
  }

  void addNewUser(String firstName , String lastName , String email , String password){
    if( ValidationRepository.isUniqueUserEmail(email)){
      String userId = Uuid().v4();
      while(!ValidationRepository.isUniqueUserId(userId)){
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
      emit(AddNewUserSuccessState(isAcceptTerms: state.isAcceptTerms));
    }
    else{
      emit(AddNewUserFailedState(isAcceptTerms: state.isAcceptTerms));
    }
  }

  bool isUniqueUserEmail(String email){
    return ValidationRepository.isUniqueUserEmail(email);
  }

}
