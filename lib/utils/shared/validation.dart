import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';

abstract class Validation{
  static bool isUniqueTicketId(List<TicketModel> tickets , String newTicketId){
    return (tickets.indexWhere((ticket)=>(ticket.ticketId == newTicketId)) == -1);
  }

  static bool isUniqueUserId(List<UserModel> users , String newUserId){
    return (users.indexWhere((user)=>(user.userId == newUserId)) == -1);
  }

  static bool isUniqueUserEmail(List<UserModel> users , String newUserEmail){
    //! old way
    // for(UserModel user in users){
    //   if(user.email == newUserEmail){
    //     return false;
    //   }
    // }
    // return true;

    //* new way
    return (users.indexWhere((user)=>(user.email == newUserEmail)) == -1);
  }

  static bool isValidateName(String name){
    return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
  }

  static bool isValidateEmail(String email){
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(email);
  }

  static bool isValidatePassword(String password){
    return RegExp(r'^[a-zA-Z0-9#?!@$%^&*-]+$').hasMatch(password);
  }

  static bool isContainUpperCase(String password){
    return RegExp(r'(?=.*[A-Z])').hasMatch(password);
  }

  static bool isContainLowerCase(String password){
    return RegExp(r'(?=.*[a-z])').hasMatch(password);
  }

  static bool isContainDigit(String password){
    return RegExp(r'(?=.*[0-9])').hasMatch(password);
  }

  static bool isContainSpecialCharacter(String password){
    return RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static UserModel isUserAccountExistInDataBase(String email , String password , List<UserModel> users){
    return users.firstWhere((user)=>(user.email == email && user.password == password) , orElse: UserModel.placeHolder);
  }

}