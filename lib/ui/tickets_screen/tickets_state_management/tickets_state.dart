part of 'tickets_cubit.dart';

@immutable
sealed class TicketsState {}

final class TicketsInitial extends TicketsState {}

final class TicketsLoading extends TicketsState {}

final class TicketsEmpty extends TicketsState {}

final class TicketsSuccess extends TicketsState {
  final List<TicketModel> tickets;

  TicketsSuccess({required this.tickets});
}

final class TicketsFailed extends TicketsState {
  final String errorMessage;

  TicketsFailed({required this.errorMessage});
}
