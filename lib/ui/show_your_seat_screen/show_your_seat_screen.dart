import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../constants/api constants/api_constants.dart';
import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';
import '../../utils/components/cinema_screen_widget.dart';
import '../../utils/shared/seats_utilities.dart';

class ShowYourSeatScreen extends StatelessWidget {
  const ShowYourSeatScreen({super.key, required this.moviePosterImage, required this.movieTitle, required this.seatNumber});

  final String moviePosterImage;
  final String movieTitle;
  final String seatNumber;
  @override
  Widget build(BuildContext context) {
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
          movieTitle,
          style: Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
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
                        imageUrl: '${ApiConstants.baseImageUrl}$moviePosterImage',
                        width: double.infinity,
                        height: ResponsiveSizeConstants.heightScreen(context) * 0.9,
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
                      left:   ResponsiveSizeConstants.widthScreen(context)*0.01,
                      right:  ResponsiveSizeConstants.widthScreen(context)*0.01,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CinemaScreenWidget(),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01,),
                            for(int i=0 ; i<5; i++)
                              _getRowSeatsWidget(i),
                            SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.015,),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top:    ResponsiveSizeConstants.heightScreen(context)*0.58,
                        left:   ResponsiveSizeConstants.widthScreen(context)*0.27,
                        right:  ResponsiveSizeConstants.widthScreen(context)*0.05,
                        child: _getSeatsInfoWidget(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

  Widget _getDefaultSeatIcon(String seatNumber , bool isYourSeat){
    return IconButton(
      onPressed: (){},
      icon: Icon(
        Icons.chair_rounded,
        color: (isYourSeat)
            ? ColorsManager.primaryBlueAccentColor
            :ColorsManager.greyColor,
        size: 25,
      ),
    );
  }

  Widget _getRowSeatsWidget(int whichRow){
    return SizedBox(
      height: 50,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: List.generate(getSizeOfEachRow(whichRow), (index){
            final String yourSeatNumber = "${getRowName(whichRow)}$index";
            return _getDefaultSeatIcon(yourSeatNumber , (yourSeatNumber == seatNumber));
          }),
        ),
      ),
    );
  }

  Widget _getSeatsInfoWidget(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.chair , color: ColorsManager.greyColor, size: 18,),
        SizedBox(width: 8,),
        Text("Other chair" , style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(width: 12,),
        Icon(Icons.chair , color: ColorsManager.primaryBlueAccentColor, size: 18,),
        SizedBox(width: 8,),
        Text("Your Seat" , style: Theme.of(context).textTheme.titleSmall,),
      ],
    );
  }

}
