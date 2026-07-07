import 'package:bloc/bloc.dart';
import 'package:cinema_app/constants/movie%20genre%20enum/movie_genre_enum.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_popular_movies_state.dart';

class GetPopularMoviesCubit extends Cubit<GetPopularMoviesState> {
  GetPopularMoviesCubit() : super(GetPopularMoviesInitial());

  final MovieRepository movieRepository = MovieRepository(dioHelper: DioHelper());

  MovieGenreEnum currentMovieGenre = MovieGenreEnum.All;

  void getPopularMovies([MovieGenreEnum genre = MovieGenreEnum.All]) async{
    emit(GetPopularMoviesLoading());
    try{
      List<MovieModel> movies = (genre.genreID == MovieGenreEnum.All.genreID) ? await movieRepository.getPopularMovies() : await movieRepository.getPopularMoviesByGenre(genre);
      emit(GetPopularMoviesSuccess(movies: movies));
    }catch(e){
      emit(GetPopularMoviesFailed(message: e.toString()));
    }
  }

  void changeCurrentMovieGenre(MovieGenreEnum genre){
    currentMovieGenre = genre;
    getPopularMovies(genre);
  }
}
