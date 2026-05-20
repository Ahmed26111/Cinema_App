import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';

abstract class Validation{
  static bool isUniqueTicketId(List<TicketModel> tickets , String newTicketId){
    for(TicketModel ticket in tickets){
      if(ticket.ticketId == newTicketId){
        return false;
      }
    }
    return true;
  }
  static bool isUniqueUserId(List<UserModel> users , String newUserId){
    for(UserModel user in users){
      if(user.userId == newUserId){
        return false;
      }
    }
    return true;
  }
  static bool isUniqueUserEmail(List<UserModel> users , String newUserEmail){
    for(UserModel user in users){
      if(user.email == newUserEmail){
        return false;
      }
    }
    return true;
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

}