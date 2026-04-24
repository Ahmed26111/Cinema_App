class TicketModel {
  final String ticketId;
  final String userId;
  final int movieId;
  final String movieName;
  final String seatNumber;
  final DateTime date;
  final String time;
  final double price;
  final String hallName;

  TicketModel({
    required this.ticketId,
    required this.userId,
    required this.movieId,
    required this.movieName,
    required this.seatNumber,
    required this.date,
    required this.time,
    required this.price,
    required this.hallName,
  });

  TicketModel copyWith(
      {String ? ticketId , String ? userId, int ? movieId, String ? movieName, String? seatNumber, DateTime? date, String ? time, double ? price, String ? hallName}) {
    return TicketModel(
        ticketId: ticketId ?? this.ticketId,
        userId: userId ?? this.userId,
        movieId: movieId ?? this.movieId,
        movieName: movieName ?? this.movieName,
        seatNumber: seatNumber ?? this.seatNumber,
        date: date ?? this.date,
        time: time ?? this.time,
        price: price ?? this.price,
        hallName: hallName ?? this.hallName ,
    );
  }

}
