import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/ui/core/layout/change_bottom_navigation_bar_index_cubit.dart';
import 'package:cinema_app/ui/favourite_movies_screen/favourite_movies_state_management/favourite_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/get_popular_movies_state_management/get_popular_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/get_top_rated_movies_state_management/get_top_rated_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/get_upcoming_movies_state_management/get_upcoming_movies_cubit.dart';
import 'package:cinema_app/ui/home_screen/home_screen.dart';
import 'package:cinema_app/ui/home_screen/home_state_management/home_cubit.dart';
import 'package:cinema_app/ui/profile_screen/profile_screen.dart';
import 'package:cinema_app/ui/profile_screen/profile_state_management/profile_cubit.dart';
import 'package:cinema_app/ui/search_screen/search_screen.dart';
import 'package:cinema_app/ui/tickets_screen/tickets_screen.dart';
import 'package:cinema_app/ui/tickets_screen/tickets_state_management/tickets_cubit.dart';
import 'package:cinema_app/ui/watch_list_movies_screen/watch_list_movies_state_management/watch_list_movies_cubit.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeBottomNavigationBarIndexCubit, ChangeBottomNavigationBarIndexState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.index, children: screens),
          bottomNavigationBar: _getCustomBottomNavigationBar(state, context),
        );
      },
    );
  }

  Container _getCustomBottomNavigationBar(ChangeBottomNavigationBarIndexState state , BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      decoration: BoxDecoration(color: ColorsManager.primaryDarkColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, "Home", state , context),
          _buildNavItem(1, Icons.search, "Search", state , context),
          _buildNavItem(2, Icons.local_movies_outlined, "Tickets", state , context),
          _buildNavItem(3, Icons.person_outline, "Profile", state , context),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label , ChangeBottomNavigationBarIndexState state , BuildContext context) {
    bool isSelected = (state.index == index);
    return GestureDetector(
      onTap: () {
        context.read<ChangeBottomNavigationBarIndexCubit>().changeBottomNavigationBarIndex(index , screens.length);
        // If user clicked the "Tickets" tab (index 2)
        if (index == 2) {
          context.read<TicketsCubit>().getUserTickets();
        }
        // If user clicked the "Tickets" tab (index 2)
        if (index == 3) {
          context.read<ProfileCubit>().getActiveUser();
          context.read<FavouriteMoviesCubit>().getFavouriteMovies();
          context.read<WatchListMoviesCubit>().getWatchListMovies();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.primarySoftColor
              : ColorsManager.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? ColorsManager.primaryBlueAccentColor
                  : ColorsManager.greyColor,
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: ColorsManager.primaryBlueAccentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

}
