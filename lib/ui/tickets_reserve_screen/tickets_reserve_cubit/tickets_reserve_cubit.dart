import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cinema_app/constants/period%20tickets%20enum/period_enum.dart';
import 'package:cinema_app/constants/seat%20status%20enum/seat_status_enum.dart';
import 'package:cinema_app/data/models/seat_model.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/hall tickets enum/hall_enum.dart';
import '../../../utils/shared/seats_utilities.dart';

part 'tickets_reserve_state.dart';

class TicketsReserveCubit extends Cubit<TicketsReserveState> {
  TicketsReserveCubit(DateTime selectedDate)
    : super(
        TicketsReserveInitial(
          selectedDate: selectedDate,
          selectedPeriod: PeriodEnum.period1,
          selectedHall: HallEnum.hall1,
          reservedSeats: [],
          seats: [],
          totalPrice: 0,
        ),
      );

  void changeSelectedDate(DateTime selectedDate , int movieId) {
    emit(
      TicketsReserveChangeSelectedDate(
        selectedDate: selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: state.seats,
        totalPrice: state.totalPrice,
      ),
    );
    getSeats(movieId);
    changeTotalPrice();
  }

  void changeSelectedPeriod(PeriodEnum selectedPeriod , int movieId) {
    emit(
      TicketsReserveChangeSelectedPeriod(
        selectedDate: state.selectedDate,
        selectedPeriod: selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: state.seats,
        totalPrice: state.totalPrice,
      ),
    );
    getSeats(movieId);
    changeTotalPrice();
  }

  void changeSelectedHall(HallEnum selectedHall , int movieId) {
    emit(
      TicketsReserveChangeSelectedHall(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: selectedHall,
        reservedSeats: state.reservedSeats,
        seats: state.seats,
        totalPrice: state.totalPrice,
      ),
    );
    getSeats(movieId);
    changeTotalPrice();
  }

  void getReservedSeats(int movieId){
    List<TicketModel> reservedTickets = HiveHandler.getReservedTickets();
    reservedTickets = reservedTickets.where((ticket)=>(
        ticket.date.year == state.selectedDate.year &&
        ticket.date.month == state.selectedDate.month &&
        ticket.date.day == state.selectedDate.day &&
        ticket.time == state.selectedPeriod.periodTime&&
        ticket.hallName == state.selectedHall.hallName&&
        ticket.movieId == movieId
    )).toList();
    emit(TicketsReserveGetReservedSeats(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: reservedTickets.map((ticket)=>ticket.seatNumber).toList(),
        seats: state.seats,
        totalPrice: state.totalPrice,
    )
    );
  }

  void changeSeatStatus(SeatStatusEnum newStatus , String seatNumber){
    int whichRow;
    switch(seatNumber[0]){
      case "A":whichRow = 0;break;
      case "B":whichRow = 1;break;
      case "C":whichRow = 2;break;
      case "D":whichRow = 3;break;
      case "E":whichRow = 4;break;
      default: whichRow = 0;
    }
    List<List<SeatModel>> seats = List.from(state.seats);
    seats[whichRow][int.parse(seatNumber[1])].seatStatus = newStatus;
    emit(TicketsReserveUpdateSeatStatus(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: seats,
        totalPrice: state.totalPrice,
    )
    );
    changeTotalPrice();
  }

  void getSeats(int movieId){
    emit(TicketsReserveInitial(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: _getSeats(movieId),
        totalPrice: state.totalPrice,
    )
    );
  }

  List<List<SeatModel>> _getSeats(int movieId){
    getReservedSeats(movieId);
    return List.generate(5, (rowIndex){
      return List.generate(getSizeOfEachRow(rowIndex), (childIndex){
        final String seatNumber = "${getRowName(rowIndex)}$childIndex";
        final bool isReserved = state.reservedSeats.contains(seatNumber);
        return SeatModel(seatStatus: (isReserved)?SeatStatusEnum.reserved:SeatStatusEnum.available, seatNumber: seatNumber);
      });
    });
  }

  void changeTotalPrice(){
    int counter = 0;
    for (var rowSeats in state.seats) {
      counter += rowSeats.where((seat) => seat.seatStatus == SeatStatusEnum.selected).length;
    }
    emit(
        TicketsReserveUpdateTotalPrice(
            selectedDate: state.selectedDate,
            selectedPeriod: state.selectedPeriod,
            selectedHall: state.selectedHall,
            reservedSeats: state.reservedSeats,
            seats: state.seats,
            totalPrice: counter*state.selectedPeriod.periodPrice,
        )
    );
  }

  void isAllChairsNotSelected(){
    List<SeatModel> selectedSeats = [];
    for (var rowSeats in state.seats) {
      selectedSeats.addAll(rowSeats.where((seat) => seat.seatStatus == SeatStatusEnum.selected).toList());
    }
    if(selectedSeats.isEmpty){
      emit(TicketsReserveAllChairsAreNotSelected(
          selectedDate: state.selectedDate,
          selectedPeriod: state.selectedPeriod,
          selectedHall: state.selectedHall,
          reservedSeats: state.reservedSeats,
          seats: state.seats,
          totalPrice: state.totalPrice
      ));
    }
    else{
      emit(TicketsReserveChairsAreSelected(
          selectedDate: state.selectedDate,
          selectedPeriod: state.selectedPeriod,
          selectedHall: state.selectedHall,
          reservedSeats: state.reservedSeats,
          seats: state.seats,
          totalPrice: state.totalPrice
      ));
    }
  }

  void buyTickets(int movieId , String movieName , String moviePosterImage){
    List<SeatModel> selectedSeats = [];
    for (var rowSeats in state.seats) {
      selectedSeats.addAll(rowSeats.where((seat) => seat.seatStatus == SeatStatusEnum.selected).toList());
    }

    if(selectedSeats.isEmpty){
      emit(TicketsReserveBuyTicketsFailed(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: state.seats,
        totalPrice: state.totalPrice,
      )
      );
      return;
    }

    UserModel userModel = HiveHandler.getActiveUser()!;

    List<TicketModel> tickets = selectedSeats.map((seat) =>
        TicketModel(
            ticketId: Uuid().v4(),
            userId: userModel.userId,
            movieId: movieId,
            movieName: movieName,
            seatNumber: seat.seatNumber,
            date: state.selectedDate,
            time: state.selectedPeriod.periodTime,
            price: state.selectedPeriod.periodPrice,
            hallName: state.selectedHall.hallName,
            moviePosterImage: moviePosterImage,
        )).toList();

    List<TicketModel> oldReservedTickets = HiveHandler.getReservedTickets();

    oldReservedTickets.addAll(tickets);
    HiveHandler.addAndUpdateReservedTickets(oldReservedTickets);

    List<TicketModel> oldUserTickets = List.from(userModel.tickets);
    oldUserTickets.addAll(tickets);
    userModel = userModel.copyWith(tickets: oldUserTickets);
    HiveHandler.addAndUpdateActiveUser(userModel);
    HiveHandler.addAndUpdateUsers(userModel);

    emit(TicketsReserveBuyTicketsSuccessfully(
        selectedDate: state.selectedDate,
        selectedPeriod: state.selectedPeriod,
        selectedHall: state.selectedHall,
        reservedSeats: state.reservedSeats,
        seats: state.seats,
        totalPrice: state.totalPrice)
    );
  }
}

