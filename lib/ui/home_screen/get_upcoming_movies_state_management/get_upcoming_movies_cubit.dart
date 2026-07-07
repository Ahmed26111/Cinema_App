import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_upcoming_movies_state.dart';

class GetUpcomingMoviesCubit extends Cubit<GetUpcomingMoviesState> {
  GetUpcomingMoviesCubit() : super(GetUpcomingMoviesInitial());
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
