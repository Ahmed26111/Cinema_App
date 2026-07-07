import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  UserModel ? _activeUser;

  UserModel? getActiveUser() {
    emit(HomeInitial());
    return HiveHandler.getActiveUser();
  }
}
