import 'package:cinema_app/data/models/movie_model.dart';

List<MovieModel> getDummyMovies(int lengthOfDummies){
  return List.generate(lengthOfDummies, (index){
    return MovieModel(
        isAdult: true,
        backdropPathImage: "/c6BPbkO5Npt1OdwttAxCFo06wtH.jpg",
        genreIds: null,
        movieId: 00000,
        movieTitle: "hgcgfhydc",
        originalLanguage: "",
        overview: "",
        posterPathImage: null,
        releaseDate: DateTime.now(),
        voteAverage: 0,
        genres: null,
        imdbId: "",
        runTime: 0,
        status: "",
        tagLine: "",
        originCountry: [],
        productionCompanies: []
    );
  });
}
