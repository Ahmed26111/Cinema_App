part of 'tickets_reserve_cubit.dart';

@immutable
sealed class TicketsReserveState {
  final DateTime selectedDate;
  final PeriodEnum selectedPeriod;
  final HallEnum selectedHall;
  final List<String> reservedSeats;
  final List<List<SeatModel>> seats;
  final double totalPrice;
  const TicketsReserveState({
    required this.selectedDate,
    required this.selectedPeriod,
    required this.selectedHall,
    required this.reservedSeats,
    required this.seats,
    required this.totalPrice,
  });
}

final class TicketsReserveInitial extends TicketsReserveState {
  const TicketsReserveInitial({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveChangeSelectedDate extends TicketsReserveState {
  const TicketsReserveChangeSelectedDate({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveChangeSelectedPeriod extends TicketsReserveState {
  const TicketsReserveChangeSelectedPeriod({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveChangeSelectedHall extends TicketsReserveState {
  const TicketsReserveChangeSelectedHall({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveGetReservedSeats extends TicketsReserveState {
  const TicketsReserveGetReservedSeats({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveUpdateSeatStatus extends TicketsReserveState {
  const TicketsReserveUpdateSeatStatus({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveUpdateTotalPrice extends TicketsReserveState {
  const TicketsReserveUpdateTotalPrice({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveBuyTicketsSuccessfully extends TicketsReserveState {
  const TicketsReserveBuyTicketsSuccessfully({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveBuyTicketsFailed extends TicketsReserveState {
  const TicketsReserveBuyTicketsFailed({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveAllChairsAreNotSelected extends TicketsReserveState {
  const TicketsReserveAllChairsAreNotSelected({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}

final class TicketsReserveChairsAreSelected extends TicketsReserveState {
  const TicketsReserveChairsAreSelected({
    required super.selectedDate,
    required super.selectedPeriod,
    required super.selectedHall,
    required super.reservedSeats,
    required super.seats,
    required super.totalPrice,
  });
}
