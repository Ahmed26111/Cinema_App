import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

part 'details_movie_state.dart';

class DetailsMovieCubit extends Cubit<DetailsMovieState> {
  DetailsMovieCubit() : super(DetailsMovieInitial());

   final MovieRepository _movieRepository = MovieRepository(dioHelper: DioHelper());
   UserModel _activeUser = HiveHandler.getActiveUser()!;

   void getDetailsMovieModel(int movieId) async{
     bool isFavourite;
     bool isWatchList;
     emit(DetailsMovieLoading());
     try{
       MovieModel movieModel = await _movieRepository.getDetailsMovieById(movieId);
       isFavourite = _activeUser.favouritesMovies.contains(movieModel);
       isWatchList = _activeUser.watchListMovies.contains(movieModel);
       emit(DetailsMovieSuccess(movie: movieModel , isFavourite: isFavourite , isWatchList: isWatchList));
     }catch(e){
       emit(DetailsMovieFailed(errorMessage: e.toString()));
     }
   }

  void toggleFavouriteMovie(){
     final currentState = state;
    if (currentState is DetailsMovieSuccess) {
      final MovieModel movie = currentState.movie;
      final bool isFavourite = _activeUser.favouritesMovies.contains(movie);
      List<MovieModel> favouritesList = List.from(_activeUser.favouritesMovies);
      if(isFavourite){
        //? isFavourite true then will deleted from the _activeUser.favouritesMoviesIds
        favouritesList.remove(movie);
      }
      else{
        //? isFavourite false then will added to _activeUser.favouritesMoviesIds
        favouritesList.add(movie);
      }
     _activeUser = _activeUser.copyWith(favouritesMovies: favouritesList);
     HiveHandler.addAndUpdateActiveUser(_activeUser);
     HiveHandler.addAndUpdateUsers(_activeUser);
      emit(DetailsMovieSuccess(movie: currentState.movie , isFavourite: !isFavourite, isWatchList: currentState.isWatchList));
    }
  }

  void toggleWatchListMovie(){
    final currentState = state;
    if (currentState is DetailsMovieSuccess) {
      final MovieModel movie = currentState.movie;
      final bool isWatchList = _activeUser.watchListMovies.contains(movie);
      List<MovieModel> watchList = List.from(_activeUser.watchListMovies);
      if(isWatchList){
        //? isWatchList true then will deleted from the _activeUser.watchListMovies
        watchList.remove(movie);
      }
      else{
        //? isWatchList false then will added to _activeUser.watchListMovies
        watchList.add(movie);
      }
      _activeUser = _activeUser.copyWith(watchListMovies: watchList);
      HiveHandler.addAndUpdateActiveUser(_activeUser);
      HiveHandler.addAndUpdateUsers(_activeUser);
      emit(DetailsMovieSuccess(movie: currentState.movie , isFavourite: currentState.isFavourite, isWatchList: !isWatchList));
    }
  }

}
