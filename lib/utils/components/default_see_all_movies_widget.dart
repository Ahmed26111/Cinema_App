import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/utils/components/default_details_movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultSeeAllMoviesWidget extends StatelessWidget {
  const DefaultSeeAllMoviesWidget({super.key, required this.appBarTitle, required this.movies});

  final String appBarTitle;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = ResponsiveSizeConstants.isLandscape(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle , style: (isLandscape)? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.labelLarge,),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: ()=>context.pop(),
              icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) => DefaultDetailsMovieCardWidget(movieModel: movies[index], isLandscape : isLandscape),
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
                    )
                ),
              ],
            ),
          ),
        ),
    );
  }
}
