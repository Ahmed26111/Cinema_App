import 'package:cinema_app/data/models/ticket_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String userId;
  final List<int> favouritesMoviesIds;
  final List<int> watchListMoviesIds;
  final List<TicketModel> tickets;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.userId,
    required this.favouritesMoviesIds,
    required this.watchListMoviesIds,
    required this.tickets,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? userId,
    List<int>? favouritesMoviesIds,
    List<int>? watchListMoviesIds,
    List<TicketModel>? tickets,
  }) {
    return UserModel(
      firstName: firstName??this.firstName,
      lastName: lastName??this.lastName,
      email: email??this.email,
      password: password??this.password,
      userId: userId??this.userId,
      favouritesMoviesIds: favouritesMoviesIds??this.favouritesMoviesIds,
      watchListMoviesIds: watchListMoviesIds??this.watchListMoviesIds,
      tickets: tickets??this.tickets,
    );
  }
}
