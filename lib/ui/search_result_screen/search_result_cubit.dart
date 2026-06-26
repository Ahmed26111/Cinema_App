import 'package:bloc/bloc.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:cinema_app/utils/shared/debouncer.dart';
import 'package:meta/meta.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit() : super(SearchResultInitial());

  final Debouncer _debouncer = Debouncer();
  final MovieRepository _movieRepository = MovieRepository(dioHelper: DioHelper());

  void onSearchChanged(String query){
    query = query.trim(); //? remove all unnecessary spaces
    if(query.isEmpty){
      emit(SearchResultInitial());
      return;
    }

    _debouncer.call(() async{
      emit(SearchResultLoading());
      try{
        final List<MovieModel> movies = await _movieRepository.getMoviesBySearch(query);
        (movies.isEmpty)?emit(SearchResultEmpty()):emit(SearchResultSuccess(movies: movies));
      }catch(error){
        emit(SearchResultFailed(message: error.toString()));
      }
    }
    );
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
