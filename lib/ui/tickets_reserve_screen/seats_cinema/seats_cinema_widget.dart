import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/hall%20tickets%20enum/hall_enum.dart';
import 'package:cinema_app/constants/period%20tickets%20enum/period_enum.dart';
import 'package:cinema_app/constants/seat%20status%20enum/seat_status_enum.dart';
import 'package:cinema_app/ui/tickets_reserve_screen/tickets_reserve_cubit/tickets_reserve_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsCinemaWidget extends StatelessWidget {
  const SeatsCinemaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsReserveCubit, TicketsReserveState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: List.generate(4, (index){
                      return _getDefaultSeatIcon(state.seats[0][index].seatStatus, state.seats[0][index].seatNumber, context);
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(6, (index){
                      return _getDefaultSeatIcon(state.seats[1][index].seatStatus, state.seats[1][index].seatNumber, context);
                  }),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(8, (index){
                    return _getDefaultSeatIcon(state.seats[2][index].seatStatus, state.seats[2][index].seatNumber, context);
                  }),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(6, (index){
                    return _getDefaultSeatIcon(state.seats[3][index].seatStatus, state.seats[3][index].seatNumber, context);
                  }),
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(4, (index){
                      return _getDefaultSeatIcon(state.seats[4][index].seatStatus, state.seats[4][index].seatNumber, context);
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getDefaultSeatIcon(SeatStatusEnum status , String seatNumber , BuildContext context){
    return IconButton(
        onPressed: (status == SeatStatusEnum.reserved)? (){} : (){
          context.read<TicketsReserveCubit>().changeSeatStatus(
              (status == SeatStatusEnum.available)
                  ? SeatStatusEnum.selected
                  : SeatStatusEnum.available
              , seatNumber
          );
        },
        icon: Icon(
            Icons.chair_rounded,
            color: (status == SeatStatusEnum.reserved)
                ? ColorsManager.primaryBlueAccentColor
                : (status == SeatStatusEnum.available)
                ? ColorsManager.greyColor
                : ColorsManager.whiteColor,
            size: 25,
        ),
    );
  }
}
