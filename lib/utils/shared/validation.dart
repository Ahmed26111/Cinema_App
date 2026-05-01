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
}