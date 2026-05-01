import 'dart:developer';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHandler.init();
  await dotenv.load(fileName: "keys.env");

  // TicketModel ticketModel = TicketModel(
  //     ticketId: "Ticket2",
  //     userId: "User1",
  //     movieId: 505,
  //     movieName: "Fight club",
  //     seatNumber: "A2",
  //     date: DateTime.now(),
  //     time: "10 pm : 12 am",
  //     price: 20,
  //     hallName: "Hall 1"
  // );

  // UserModel user = UserModel(
  //     firstName: "test",
  //     lastName: "test",
  //     email: "test@gmail.com",
  //     password: "test",
  //     userId: "User1",
  //     favouritesMoviesIds: <int>[505,1000],
  //     watchListMoviesIds: <int>[505,500],
  //     tickets: <TicketModel>[ticketModel]
  // );
  //
  // HiveHandler.addAndUpdateUsers(user);

  // HiveHandler.deleteUser("User1");

  try {
    List<UserModel> users = HiveHandler.getAllUsers();
    log("users size = ${users.length}");
    for(UserModel userModel in users){
      log("====================================");
      log("User Id : ${userModel.userId}");
      log("User First Name : ${userModel.firstName}");
      log("User Last Name : ${userModel.lastName}");
      log("User Email : ${userModel.email}");
      log("User Password : ${userModel.password}");
      log("User Reserved Tickets is : ${userModel.tickets.length}");
      for(TicketModel ticket in userModel.tickets){
        log("Ticket Id ${ticket.ticketId}");
        log("Ticket Id ${ticket.movieId}");
        log("Ticket Id ${ticket.userId}");
        log("Ticket Id ${ticket.movieName}");
        log("Ticket Id ${ticket.time}");
        log("Ticket Id ${ticket.hallName}");
        log("Ticket Id ${ticket.price}");
        log("Ticket Id ${ticket.seatNumber}");
        log("Ticket Id ${ticket.date.year}/${ticket.date.month}/${ticket.date.day}");
      }
      log("User Watch List Movies : ${userModel.watchListMoviesIds}");
      log("User Favourites Movies : ${userModel.favouritesMoviesIds}");
      log("====================================");
    }
  }
  catch (e) {
    log("error : ${e.toString()}");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Placeholder(),
    );
  }
}
