import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit() : super(SimilarMoviesInitial());

  final MovieRepository _movieRepository = MovieRepository(dioHelper: DioHelper());

  void getSimilarMoviesByMovieId(int movieId) async{
    emit(SimilarMoviesLoading());
    try{
      final List<MovieModel> movies = await _movieRepository.getSimilarMoviesById(movieId);
      if(movies.isEmpty){
        emit(SimilarMoviesEmpty());
      }
      else{
        emit(SimilarMoviesSuccess(movies: movies));
      }
    }catch(e){
      emit(SimilarMoviesFailed(errorMessage: e.toString()));
    }
  }

}
