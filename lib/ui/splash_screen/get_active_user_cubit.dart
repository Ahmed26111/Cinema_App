import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_active_user_state.dart';

class GetActiveUserCubit extends Cubit<GetActiveUserState> {
  GetActiveUserCubit() : super(GetActiveUserInitial());

  static GetActiveUserCubit get (BuildContext context) => BlocProvider.of(context);

  UserModel? getActiveUser(){
    return HiveHandler.getActiveUser();
  }

}
