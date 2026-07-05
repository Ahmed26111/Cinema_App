import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/constants/routes%20constants/routes_constants.dart';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/ui/tickets_screen/tickets_state_management/tickets_cubit.dart';
import 'package:cinema_app/utils/components/default_empty_list_widget.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/ticket_container_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Tickets",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<TicketsCubit, TicketsState>(
        builder: (context, state) {
          switch(state){
            case TicketsInitial() || TicketsLoading():{
              return Skeletonizer(
                containersColor: ColorsManager.greyColor,
                effect: ShimmerEffect(
                  baseColor: ColorsManager.greyColor,
                  highlightColor: ColorsManager.lineDarkColor,
                ),
                enabled: true ,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(int i=0 ; i<5 ; i++)
                        _getTicketsInfo(context, TicketModel.placeHolder()),
                    ],
                  ),
                ),
              );
            }
            case TicketsEmpty() : {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultEmptyListWidget(
                        message: "There is no tickets yet!",
                        helpMessage: "book a ticket for best movies now",
                    ),
                  ],
                ),
              );
            }
            case TicketsSuccess():{
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for(TicketModel ticket in state.tickets)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: _getTicketsInfo(context, ticket),
                      ),
                  ],
                ),
              );
            }
            case TicketsFailed():{
              return DefaultFailedToLoadWidget(
                  errorMessage: "Sorry , Failed to load your tickets :-(",
                  helpMessage: "please , restart your application"
              );
            }
          }
        },
      ),
    );
  }

  Widget _getTicketsInfo(BuildContext context , TicketModel ticket){
    return GestureDetector(
      onLongPress: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            backgroundColor: ColorsManager.primarySoftColor,
            scrollable: true,
            title: QrImageView(
              data: ticket.ticketId,
              version: QrVersions.auto,
              // Automatically calculate the complexity
              size: 200.0,
              // Size of the QR code
              gapless: false,
              // Ensures no white lines between pixels
              backgroundColor: ColorsManager.whiteColor,
              // Standard for better scanning
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.black,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Movie Title:\t\t" ,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      Expanded(
                        child: Text(
                          ticket.movieName,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Date: " ,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      Text(
                        formatDate(ticket.date, [yyyy,"-",mm,"-",dd]),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Period: " ,
                        style: Theme.of(context).textTheme.labelLarge
                    ),
                      Text(
                          ticket.time,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "Hall: " ,
                          style: Theme.of(context).textTheme.labelLarge
                      ),
                      Text(
                          ticket.hallName,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Price: " ,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      Text(
                        ticket.price.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "Seat number: " ,
                          style: Theme.of(context).textTheme.labelLarge
                      ),
                      Text(
                          ticket.seatNumber,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05)
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              FilledButton(
                onPressed: (){
                  context.pushNamed(RoutesConstants.showYourSeatScreenName , pathParameters: {
                    "moviePosterImage":ticket.moviePosterImage,
                    "movieTitle":ticket.movieName,
                    "seatNumber":ticket.seatNumber
                  });
                },
                style: FilledButton.styleFrom(
                    backgroundColor: ColorsManager.primaryBlueAccentColor
                ),
                child: Text(
                  "Show your seat",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.039
                  ),
                ),
              ),
              FilledButton(
                  onPressed: (){
                    context.pop();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: ColorsManager.primaryBlueAccentColor
                  ),
                  child: Text(
                      "Close",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: ResponsiveSizeConstants.widthScreen(context)*0.035
                    ),
                  ),
              ),
            ],
          );
        });
      },
      child: TicketContainerWidget(
        height: ResponsiveSizeConstants.heightScreen(context)*0.1875,
        color: ColorsManager.lineDarkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cinema Max",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: ResponsiveSizeConstants.widthScreen(context)*0.06
              ),
            ),
            Row(
              children: [
                SizedBox(width: ResponsiveSizeConstants.widthScreen(context) * 0.2,),
                Text(
                  "Movie Title:\t\t" ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.blackColor,
                    fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Expanded(
                  child: Text(
                    ticket.movieName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorsManager.primaryBlueAccentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Date: " ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.blackColor,
                    fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  formatDate(ticket.date, [yyyy,"-",mm,"-",dd]),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.primaryBlueAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  " \t\t Period: " ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.blackColor,
                    fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  ticket.time,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.primaryBlueAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Seat number: " ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.blackColor,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  ticket.seatNumber,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.primaryBlueAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  " \t\t Hall: " ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.blackColor,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  ticket.hallName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.primaryBlueAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Price: " ,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.blackColor,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045
                  ),
                ),
                Text(
                  ticket.price.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.primaryBlueAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveSizeConstants.widthScreen(context)*0.045),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
