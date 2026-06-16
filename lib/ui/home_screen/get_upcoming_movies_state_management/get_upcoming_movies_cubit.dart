import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_upcoming_movies_state.dart';

class GetUpcomingMoviesCubit extends Cubit<GetUpcomingMoviesState> {
  GetUpcomingMoviesCubit() : super(GetUpcomingMoviesInitial());
  final MovieRepository movieRepository = MovieRepository(dioHelper: DioHelper());
  void getTopRatedMovies() async{
    emit(GetTopRatedMoviesLoading());
    try{
      List<MovieModel> movies = await movieRepository.getTopRatedMovies();
      emit(GetTopRatedMoviesSuccess(movies: movies));
    }catch(e){
      emit(GetTopRatedMoviesFailed(message: e.toString()));
    }
  }

}
