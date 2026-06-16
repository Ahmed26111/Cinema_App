import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_top_rated_movies_state.dart';

class GetTopRatedMoviesCubit extends Cubit<GetTopRatedMoviesState> {
  GetTopRatedMoviesCubit() : super(GetTopRatedMoviesInitial());
  final MovieRepository movieRepository = MovieRepository(dioHelper: DioHelper());

  void getUpComingMovies() async{
    emit(GetUpComingMoviesLoading());
    try{
      List<MovieModel> movies = await movieRepository.getUpComingMovies();
      emit(GetUpComingMoviesSuccess(movies: movies));
    }catch(e){
      emit(GetUpComingMoviesFailed(message: e.toString()));
    }
  }

}
