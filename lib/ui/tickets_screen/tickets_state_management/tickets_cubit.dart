import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user/user_model.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit() : super(TicketsInitial());

  void getUserTickets(){
    emit(TicketsLoading());
    try{
      UserModel ? activeUser = HiveHandler.getActiveUser();
      if(activeUser != null){
        List<TicketModel> tickets = activeUser.tickets;
        emit(TicketsSuccess(tickets: tickets));
      }
      else{
        throw Exception("Failed to get your tickets");
      }
    }catch(e){
      emit(TicketsFailed(errorMessage: e.toString()));
    }
  }

}
