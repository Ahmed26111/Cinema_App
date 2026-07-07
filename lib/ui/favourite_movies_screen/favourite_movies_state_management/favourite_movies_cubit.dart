import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:meta/meta.dart';

part 'favourite_movies_state.dart';

class FavouriteMoviesCubit extends Cubit<FavouriteMoviesState> {
  FavouriteMoviesCubit() : super(FavouriteMoviesInitial());

  void getFavouriteMovies() {
    emit(FavouriteMoviesLoading());
    try {
      // Always get the fresh user from Hive
      UserModel? activeUser = HiveHandler.getActiveUser();

      if (activeUser != null) {
        final List<MovieModel> favouriteMovies = activeUser.favouritesMovies;
        if (favouriteMovies.isEmpty) {
          emit(FavouriteMoviesEmpty());
        } else {
          emit(FavouriteMoviesSuccess(favouriteMovies: favouriteMovies));
        }
      } else {
        throw Exception("There is no active user");
      }
    } catch (e) {
      emit(FavouriteMoviesFailed(errorMessage: e.toString()));
    }
  }

  void removeMovieFromFavourites(MovieModel movie) {
    UserModel? activeUser = HiveHandler.getActiveUser();
    if (activeUser != null) {
      List<MovieModel> temp = List.from(activeUser.favouritesMovies);
      temp.remove(movie);

      // Update Hive with the new list
      UserModel updatedUser = activeUser.copyWith(favouritesMovies: temp);
      HiveHandler.addAndUpdateActiveUser(updatedUser);
      HiveHandler.addAndUpdateUsers(updatedUser);

      // Refresh the UI state
      getFavouriteMovies();
    }
  }
}