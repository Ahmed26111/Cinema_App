import 'package:cinema_app/constants/hive%20constants/hive_constants.dart';
import 'package:cinema_app/data/models/ticket/ticket_adapter.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_adapter.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHandler{
  static late Box usersBox;
  static late Box activeUserBox;
  static late Box ticketsBox;

  static Future<void> init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TicketAdapter());
    usersBox =await Hive.openBox(HiveConstants.usersBox);
    activeUserBox =await Hive.openBox(HiveConstants.activeUserBox);
    ticketsBox =await Hive.openBox(HiveConstants.ticketsBox);
  }

  static void addAndUpdateUsers(UserModel user) async{
     return await usersBox.put(user.userId, user);
  }

  static void deleteUser(String userId) async{
    return await usersBox.delete(userId);
  }

  static List<UserModel> getAllUsers(){
    return List.from(usersBox.values).cast<UserModel>();
  }

  static void addAndUpdateActiveUser(UserModel user)async{
    return await activeUserBox.put(HiveConstants.activeKey, user);
  }

  static UserModel? getActiveUser(){
    return activeUserBox.get(HiveConstants.activeKey , defaultValue: null);
  }

  static void deleteActiveUser() async{
    return await activeUserBox.delete(HiveConstants.activeKey);
  }

  static void addAndUpdateReservedTickets(List<TicketModel> tickets) async{
    return await ticketsBox.put(HiveConstants.reservedTicketsKey, tickets);
  }

  static List<TicketModel> getReservedTickets(){
    return List.from(ticketsBox.get(HiveConstants.reservedTicketsKey , defaultValue: [])).cast<TicketModel>();
  }
  
}