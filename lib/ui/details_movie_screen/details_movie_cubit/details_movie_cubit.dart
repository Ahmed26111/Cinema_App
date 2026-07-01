import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie_model.dart';
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
       isFavourite = _activeUser.favouritesMoviesIds.contains(movieId);
       isWatchList = _activeUser.watchListMoviesIds.contains(movieId);
       emit(DetailsMovieSuccess(movie: movieModel , isFavourite: isFavourite , isWatchList: isWatchList));
     }catch(e){
       emit(DetailsMovieFailed(errorMessage: e.toString()));
     }
   }

  void toggleFavouriteMovie(){
     final currentState = state;
    if (currentState is DetailsMovieSuccess) {
     final int movieId = currentState.movie.movieId;
      final bool isFavourite = _activeUser.favouritesMoviesIds.contains(movieId);
      List<int> favouritesList = List.from(_activeUser.favouritesMoviesIds);
      if(isFavourite){
        //? isFavourite true then will deleted from the _activeUser.favouritesMoviesIds
        favouritesList.remove(movieId);
      }
      else{
        //? isFavourite false then will added to _activeUser.favouritesMoviesIds
        favouritesList.add(movieId);
      }
     _activeUser = _activeUser.copyWith(favouritesMoviesIds: favouritesList);
     HiveHandler.addAndUpdateActiveUser(_activeUser);
      emit(DetailsMovieSuccess(movie: currentState.movie , isFavourite: !isFavourite, isWatchList: currentState.isWatchList));
    }
  }

  void toggleWatchListMovie(){
    final currentState = state;
    if (currentState is DetailsMovieSuccess) {
      final int movieId = currentState.movie.movieId;
      final bool isWatchList = _activeUser.watchListMoviesIds.contains(movieId);
      List<int> watchList = List.from(_activeUser.watchListMoviesIds);
      if(isWatchList){
        //? isWatchList true then will deleted from the _activeUser.watchListMoviesIds
        watchList.remove(movieId);
      }
      else{
        //? isWatchList false then will added to _activeUser.watchListMoviesIds
        watchList.add(movieId);
      }
      _activeUser = _activeUser.copyWith(watchListMoviesIds: watchList);
      HiveHandler.addAndUpdateActiveUser(_activeUser);
      emit(DetailsMovieSuccess(movie: currentState.movie , isFavourite: currentState.isFavourite, isWatchList: !isWatchList));
    }
  }

}
