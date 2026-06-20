enum MovieGenreEnum{
  action(genreID: 28),
  adventure(genreID: 12),
  animation(genreID: 16),
  comedy(genreID: 35),
  crime(genreID: 80),
  documentary(genreID: 99),
  drama(genreID: 18),
  family(genreID: 10751),
  fantasy(genreID: 14),
  history(genreID: 36),
  horror(genreID: 27),
  music(genreID: 10402),
  mystery(genreID: 9648),
  romance(genreID: 10749),
  scienceFiction(genreID: 878),
  tvMovie(genreID: 10770),
  thriller(genreID: 53),
  war(genreID: 10752),
  western(genreID: 37),
  all(genreID: -1);
  final int genreID;
  const MovieGenreEnum({required this.genreID});
}



