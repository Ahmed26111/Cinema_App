import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_popular_movies_state.dart';

class GetPopularMoviesCubit extends Cubit<GetPopularMoviesState> {
  GetPopularMoviesCubit() : super(GetPopularMoviesInitial());

  final MovieRepository movieRepository = MovieRepository(dioHelper: DioHelper());
  void getPopularMovies() async{
    emit(GetPopularMoviesLoading());
    try{
      List<MovieModel> movies = await movieRepository.getPopularMovies();
      emit(GetPopularMoviesSuccess(movies: movies));
    }catch(e){
      emit(GetPopularMoviesFailed(message: e.toString()));
    }
  }
}
