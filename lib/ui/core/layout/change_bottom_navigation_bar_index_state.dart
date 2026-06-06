part of 'change_bottom_navigation_bar_index_cubit.dart';

@immutable
sealed class ChangeBottomNavigationBarIndexState {
  final int index;

  const ChangeBottomNavigationBarIndexState({required this.index});
}

final class ChangeBottomNavigationBarIndexInitial extends ChangeBottomNavigationBarIndexState {
  const ChangeBottomNavigationBarIndexInitial({required super.index});
}
