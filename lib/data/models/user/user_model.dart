import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String userId;
  final List<MovieModel> favouritesMovies;
  final List<MovieModel> watchListMovies;
  final List<TicketModel> tickets;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.userId,
    required this.favouritesMovies,
    required this.watchListMovies,
    required this.tickets,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? userId,
    List<MovieModel>? favouritesMovies,
    List<MovieModel>? watchListMovies,
    List<TicketModel>? tickets,
  }) {
    return UserModel(
      firstName: firstName??this.firstName,
      lastName: lastName??this.lastName,
      email: email??this.email,
      password: password??this.password,
      userId: userId??this.userId,
      favouritesMovies: favouritesMovies??this.favouritesMovies,
      watchListMovies: watchListMovies??this.watchListMovies,
      tickets: tickets??this.tickets,
    );
  }

  factory UserModel.placeHolder(){
    return UserModel(firstName: "",
        lastName: "",
        email: "",
        password: "",
        userId: "",
        favouritesMovies: <MovieModel>[],
        watchListMovies: <MovieModel>[],
        tickets: <TicketModel>[]);
  }

  @override
  List<Object?> get props => [userId];


}
