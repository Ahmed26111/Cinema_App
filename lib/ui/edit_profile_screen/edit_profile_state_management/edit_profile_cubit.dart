import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/validation_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  UserModel ? getActiveUser(){
   return HiveHandler.getActiveUser();
  }

  void editUser({required String firstName, required String lastName, required String email}){
    UserModel ? activeUser = HiveHandler.getActiveUser();
    if(activeUser != null && (firstName != activeUser.firstName || lastName != activeUser.lastName || email != activeUser.email) ){
      activeUser = activeUser.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email
      );
      HiveHandler.addAndUpdateActiveUser(activeUser);
      HiveHandler.addAndUpdateUsers(activeUser);
      emit(EditProfileSuccess());
    }
    else{
      emit(EditProfileFailed());
    }
  }

  bool isUniqueUserEmail(String email){
    UserModel ? activeUser = HiveHandler.getActiveUser();
    return ((activeUser?.email==email) || ValidationRepository.isUniqueUserEmail(email));
  }

}
