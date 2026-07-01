import 'package:cinema_app/constants/seat%20status%20enum/seat_status_enum.dart';

class SeatModel{
  SeatStatusEnum seatStatus;
  String seatNumber;

  SeatModel({required this.seatStatus, required this.seatNumber});
}