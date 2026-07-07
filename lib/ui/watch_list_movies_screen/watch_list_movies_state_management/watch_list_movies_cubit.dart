import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

part 'watch_list_movies_state.dart';

class WatchListMoviesCubit extends Cubit<WatchListMoviesState> {
  WatchListMoviesCubit() : super(WatchListMoviesInitial());

  void getWatchListMovies(){
    emit(WatchListMoviesLoading());
    try{
      UserModel ? activeUser = HiveHandler.getActiveUser();
      if(activeUser != null){
        final List<MovieModel> watchListMovies = activeUser.watchListMovies;
        if(watchListMovies.isEmpty){
          emit(WatchListMoviesEmpty());
        }
        else{
          emit(WatchListMoviesSuccess(watchListMovies: watchListMovies));
        }
      }
      else{
        throw Exception("there is no active user");
      }
    }catch(e){
      emit(WatchListMoviesFailed(errorMessage: e.toString()));
    }
  }

  void removeMovieFromWatchLists(MovieModel movie){
    UserModel ? activeUser = HiveHandler.getActiveUser();
    if(activeUser != null) {
      List<MovieModel> temp = List.from(activeUser.watchListMovies);
      temp.remove(movie);
      UserModel newUser = activeUser.copyWith(watchListMovies: temp);
      HiveHandler.addAndUpdateActiveUser(newUser);
      HiveHandler.addAndUpdateUsers(newUser);
      getWatchListMovies();
    }
  }

}
