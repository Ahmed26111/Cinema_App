import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getActiveUser(){
    emit(GetActiveUserLoading());
    try{
      final UserModel ? activeUser =  HiveHandler.getActiveUser();
      if(activeUser != null){
        emit(GetActiveUserSuccessfully(activeUser: activeUser));
      }
      else{
        throw Exception("There is no active user");
      }
    }catch(e){
      emit(GetActiveUserFailed(errorMessage: e.toString()));
    }
  }
}
