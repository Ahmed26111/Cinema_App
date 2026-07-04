import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_app/constants/hall%20tickets%20enum/hall_enum.dart';
import 'package:cinema_app/constants/period%20tickets%20enum/period_enum.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/ui/tickets_reserve_screen/seats_cinema/seats_cinema_widget.dart';
import 'package:cinema_app/ui/tickets_reserve_screen/tickets_reserve_cubit/tickets_reserve_cubit.dart';
import 'package:cinema_app/ui/tickets_screen/tickets_state_management/tickets_cubit.dart';
import 'package:cinema_app/utils/components/cinema_screen_widget.dart';
import 'package:cinema_app/utils/components/failed_to_buy_tickets_snackbar.dart';
import 'package:cinema_app/utils/components/seats_are_empty_snackbar.dart';
import 'package:cinema_app/utils/components/tickets_are_bought_successfully_snackbar.dart';
import 'package:cinema_app/utils/shared/get_selected_date_time.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/api constants/api_constants.dart';
import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';

class TicketsReserveScreen extends StatefulWidget {
  const TicketsReserveScreen({super.key, required this.movieModel});

  final MovieModel movieModel;

  @override
  State<TicketsReserveScreen> createState() => _TicketsReserveScreenState();
}

class _TicketsReserveScreenState extends State<TicketsReserveScreen> {
  @override
  Widget build(BuildContext context) {
    final DateTime startDate = getSelectedDateTime(widget.movieModel.releaseDate);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.transparent,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.transparent,
        ),
        leading: _getBackFilledIconButton(context),
        leadingWidth: 80,
        title: Text(
          widget.movieModel.movieTitle,
          style: Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: BlocConsumer<TicketsReserveCubit, TicketsReserveState>(
        listener: (context , state){
          if(state is TicketsReserveChairsAreSelected){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                backgroundColor: ColorsManager.primarySoftColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Are you sure you want to\nbuy these tickets?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  // No Button
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      "No",
                      style: TextStyle(color: ColorsManager.greyColor),
                    ),
                  ),
                  // Yes Button
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: ColorsManager.primaryBlueAccentColor,
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<TicketsReserveCubit>().buyTickets(
                        widget.movieModel.movieId,
                        widget.movieModel.movieTitle,
                        widget.movieModel.posterPathImage ?? "",
                      );
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            );
          }

          else if(state is TicketsReserveAllChairsAreNotSelected){
            ScaffoldMessenger.of(context).showSnackBar(SeatsAreEmptySnackBar.get(context));
          }

          else if(state is TicketsReserveBuyTicketsFailed){
            ScaffoldMessenger.of(context).showSnackBar(FailedToBuyTicketsSnackBar.get(context));
          }

          else if(state is TicketsReserveBuyTicketsSuccessfully){
            ScaffoldMessenger.of(context).showSnackBar(TicketsAreBoughtSuccessfullySnackBar.get(context));
            context.read<TicketsCubit>().getUserTickets();
            context.pop();
          }

        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorsManager
                                    .primarySoftColorLessOpacityLinearGradientStart,
                                ColorsManager
                                    .primarySoftColorLessOpacityLinearGradientEnd,
                              ],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstATop,
                          child: CachedNetworkImage(
                            imageUrl: '${ApiConstants.baseImageUrl}${widget.movieModel
                                .posterPathImage}',
                            width: double.infinity,
                            height: ResponsiveSizeConstants.heightScreen(context) * 0.625,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(
                                  color: ColorsManager.primarySoftColor,
                                  child: Center(child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorsManager
                                        .primaryBlueAccentColor,)),
                                ),
                            errorWidget: (context, url, error) =>
                                Image.asset(
                                  "images/default_poster.png",
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        Positioned(
                            top:    ResponsiveSizeConstants.heightScreen(context)*0.15,
                            left:   ResponsiveSizeConstants.widthScreen(context)*0.05,
                            right:  ResponsiveSizeConstants.widthScreen(context)*0.05,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(formatDate(startDate, [MM]) , style: Theme.of(context).textTheme.labelMedium,),
                                  SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.015),
                                  _getDatesListView(state, startDate),
                                  SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.01),
                                  Text("Select Time" , style: Theme.of(context).textTheme.labelMedium,),
                                  SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.015),
                                  _getPeriodsListView(state),
                                  SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.015),
                                  Text("Select Hall" , style: Theme.of(context).textTheme.labelMedium,),
                                  SizedBox(height: ResponsiveSizeConstants.heightScreen(context)*0.015),
                                  _getHallsListView(state),
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                    CinemaScreenWidget(),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                    _getSeatsWidget(),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02,),
                    _getTotalPrice(state, context),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.025,),
                    _getBuyTicketButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconButton _getBackFilledIconButton(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        context.pop();
      },
      icon: Icon(Icons.arrow_back_ios_new, color: ColorsManager.whiteColor , size: 20,),
      style: IconButton.styleFrom(
          backgroundColor: ColorsManager.primarySoftColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )
      ),
    );
  }

  Widget _getDatesListView(TicketsReserveState state  , DateTime startDate){
    final List<DateTime> datesOptions = List.generate(7, (index){return startDate.add(Duration(days: index));});
    return SizedBox(
      height: 80,
      child: ListView.builder(
          itemBuilder: (context , index) {
            final bool isSelectedDate =
                datesOptions[index].year == state.selectedDate.year &&
                    datesOptions[index].month == state.selectedDate.month &&
                    datesOptions[index].day == state.selectedDate.day;
            return Column(
            children: [
              _getCardDate(datesOptions[index], isSelectedDate, context),
              SizedBox(height: 4,),
              Text(formatDate(datesOptions[index], [D]) ,
                style: isSelectedDate ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.titleSmall,
              ),
            ],
          );
          },
          itemCount: datesOptions.length,
          scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getCardDate(DateTime date , bool isSelected, BuildContext context){
    return GestureDetector(
      onTap: () => context.read<TicketsReserveCubit>().changeSelectedDate(date , widget.movieModel.movieId),
      child: Card(
          color: (isSelected) ? ColorsManager.primaryBlueAccentColor : ColorsManager.primarySoftColorLessOpacity,
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          borderOnForeground: false,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                formatDate(date, [dd]),
                style: (isSelected) ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.titleSmall,
            ),
          ),
      ),
    );
  }

  Widget _getPeriodsListView(TicketsReserveState state){
    return SizedBox(
      height: 50,
      child: ListView.separated(
        itemBuilder: (context , index) => _getButtonPeriod(PeriodEnum.values[index], (state.selectedPeriod == PeriodEnum.values[index]), context),
        itemCount: PeriodEnum.values.length,
        separatorBuilder: (context , index) => SizedBox(width: 4,),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getButtonPeriod(PeriodEnum period , bool isSelected, BuildContext context){
    return FilledButton(
        onPressed: (){
          context.read<TicketsReserveCubit>().changeSelectedPeriod(period , widget.movieModel.movieId);
        },
        style: FilledButton.styleFrom(
          backgroundColor: (isSelected) ? ColorsManager.primaryBlueAccentColor : ColorsManager.primarySoftColorLessOpacity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          period.periodTime ,
          style: (isSelected)? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.titleSmall,
        ),
    );
  }

  Widget _getHallsListView(TicketsReserveState state){
    return SizedBox(
      height: 50,
      child: ListView.separated(
        itemBuilder: (context , index) => _getButtonHall(HallEnum.values[index], (HallEnum.values[index] == state.selectedHall), context),
        itemCount: HallEnum.values.length,
        separatorBuilder: (context , index) => SizedBox(width: 4,),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getButtonHall(HallEnum hall , bool isSelected, BuildContext context){
    return FilledButton(
      onPressed: (){
        context.read<TicketsReserveCubit>().changeSelectedHall(hall , widget.movieModel.movieId);
      },
      style: FilledButton.styleFrom(
        backgroundColor: (isSelected) ? ColorsManager.primaryBlueAccentColor : ColorsManager.primarySoftColorLessOpacity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        hall.hallName ,
        style: (isSelected)? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget _getSeatsWidget(){
    return SeatsCinemaWidget();
  }

  Widget _getTotalPrice(TicketsReserveState state , BuildContext context){
    return Text("Total Price : ${state.totalPrice.toString()}" , style: Theme.of(context).textTheme.labelMedium,);
  }

  Widget _getBuyTicketButton(BuildContext context){
    return FilledButton(
      onPressed: (){
        context.read<TicketsReserveCubit>().isAllChairsNotSelected();
      },
      style: FilledButton.styleFrom(
        backgroundColor: ColorsManager.primaryBlueAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        )
      ),
      child: Text("Buy Tickets" , style: Theme.of(context).textTheme.labelMedium,),
    );
  }
}
