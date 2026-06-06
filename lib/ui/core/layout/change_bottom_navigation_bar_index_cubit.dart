import 'package:bloc/bloc.dart';
import 'package:cinema_app/utils/shared/validation.dart';
import 'package:meta/meta.dart';

part 'change_bottom_navigation_bar_index_state.dart';

class ChangeBottomNavigationBarIndexCubit extends Cubit<ChangeBottomNavigationBarIndexState> {
  ChangeBottomNavigationBarIndexCubit() : super(ChangeBottomNavigationBarIndexInitial(index: 0));

  void changeBottomNavigationBarIndex(int index , int sizeOfScreenList){
    if(index >= 0 && index < sizeOfScreenList){
      emit(ChangeBottomNavigationBarIndexInitial(index: index));
    }
  }
}
