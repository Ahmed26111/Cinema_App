import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:cinema_app/utils/shared/validation.dart';

abstract class ValidationRepository{

  static bool isUniqueUserEmail(String email){
    List<UserModel> users = HiveHandler.getAllUsers();
    return Validation.isUniqueUserEmail(users, email);
  }

  static bool isUniqueUserId(String userID){
    List<UserModel> users = HiveHandler.getAllUsers();
    return Validation.isUniqueUserId(users, userID);
  }

  static bool updateUserPasswordByEmail(String email,String password){
    List<UserModel> users = HiveHandler.getAllUsers();
    UserModel user =  users.firstWhere((user)=>(user.email == email) , orElse: UserModel.placeHolder);
    if(user.userId != ""){
      user = user.copyWith(password: password);
      HiveHandler.addAndUpdateUsers(user);
      return true;
    }
    else{
      return false;
    }
  }

}