import 'package:bloc/bloc.dart';
import 'package:cinema_app/constants/movie%20genre%20enum/movie_genre_enum.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:meta/meta.dart';

part 'get_top_rated_movies_state.dart';

class GetTopRatedMoviesCubit extends Cubit<GetTopRatedMoviesState> {
  GetTopRatedMoviesCubit() : super(GetTopRatedMoviesInitial());
  final MovieRepository movieRepository = MovieRepository(
    dioHelper: DioHelper(),
  );

  MovieGenreEnum currentMovieGenre = MovieGenreEnum.All;

  void getTopRatedMovies([MovieGenreEnum genre = MovieGenreEnum.All]) async {
    emit(GetTopRatedMoviesLoading());
    try {
      List<MovieModel> movies = (genre.genreID == MovieGenreEnum.All.genreID) ? await movieRepository.getTopRatedMovies() : await movieRepository.getTopRatedMoviesByGenre(genre);
      emit(GetTopRatedMoviesSuccess(movies: movies));
    } catch (e) {
      emit(GetTopRatedMoviesFailed(message: e.toString()));
    }
  }

  void changeCurrentMovieGenre(MovieGenreEnum genre){
    currentMovieGenre = genre;
    getTopRatedMovies(genre);
  }
}
