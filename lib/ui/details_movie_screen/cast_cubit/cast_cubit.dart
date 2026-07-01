import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/cast_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  CastCubit() : super(CastInitial());

  final MovieRepository _movieRepository = MovieRepository(dioHelper: DioHelper());

  void getCastsByMovieId(int movieId) async{
    emit(CastLoading());
    try{
      final List<CastModel> casts = await _movieRepository.getCastsByMovieId(movieId);
      emit(CastSuccess(casts: casts));
    }catch(e){
      emit(CastFailed(errorMessage: e.toString()));
    }
  }

}
