import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'movie_certification_state.dart';

class MovieCertificationCubit extends Cubit<MovieCertificationState> {
  MovieCertificationCubit() : super(MovieCertificationInitial());

  final MovieRepository _movieRepository = MovieRepository(dioHelper: DioHelper());

  void getMovieCertification(int movieId) async{
    emit(MovieCertificationLoading());
    try{
      final String certification = await _movieRepository.getMovieCertification(movieId);
      emit(MovieCertificationSuccess(certification: certification));
    }catch(e){
      emit(MovieCertificationError(errorMessage: e.toString()));
    }
  }

}
