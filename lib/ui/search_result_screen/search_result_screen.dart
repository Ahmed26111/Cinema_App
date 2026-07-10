import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/search_result_screen/search_result_cubit.dart';
import 'package:cinema_app/utils/components/default_empty_movie_widget.dart';
import 'package:cinema_app/utils/components/default_failed_to_load_widget.dart';
import 'package:cinema_app/utils/components/default_search_bar_widget.dart';
import 'package:cinema_app/utils/components/get_movies_vertical_list_view.dart';
import 'package:cinema_app/utils/shared/getDummyMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/color constants/colors_manager.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false, //? it does not resize the widgets when the key board is open
      body: BlocBuilder<SearchResultCubit, SearchResultState>(
        builder: (context, state) {
          return GestureDetector(
            onVerticalDragDown: (drag){
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DefaultSearchBarWidget(
                              controller: _searchController,
                              hintText: "Type title, categories, years, etc",
                              isSearchResult: true,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.pop();
                            },
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.025 ,),
                      if (state is SearchResultEmpty || state is SearchResultFailed)
                          SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.07 ,),

                      switch(state){
                        SearchResultInitial() => SizedBox(),
                        SearchResultLoading() => Expanded(
                          child: Skeletonizer(
                              containersColor: ColorsManager.greyColor,
                              effect: ShimmerEffect(
                                baseColor: ColorsManager.greyColor,
                                highlightColor: ColorsManager.lineDarkColor,
                              ),
                              enabled: true,
                              child: GetMoviesVerticalListView(
                                  movies: getDummyMovies(10),
                                  isDummy: true,
                              ),
                          ),
                        ),
                        SearchResultEmpty() => DefaultEmptyMovieWidget(searchQuery: _searchController.text),
                        SearchResultSuccess() => Expanded(
                          child: GetMoviesVerticalListView(movies: state.movies),
                        ),
                        SearchResultFailed() => DefaultFailedToLoadWidget(
                          errorMessage: "Failed to load the movies",
                          helpMessage: "Please try to connect with internet",
                        ),
                      }
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
