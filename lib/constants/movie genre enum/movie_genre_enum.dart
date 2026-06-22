enum MovieGenreEnum{
  Action(genreID: 28),
  Adventure(genreID: 12),
  Animation(genreID: 16),
  Comedy(genreID: 35),
  Crime(genreID: 80),
  Documentary(genreID: 99),
  Drama(genreID: 18),
  Family(genreID: 10751),
  Fantasy(genreID: 14),
  History(genreID: 36),
  Horror(genreID: 27),
  Music(genreID: 10402),
  Mystery(genreID: 9648),
  Romance(genreID: 10749),
  ScienceFiction(genreID: 878),
  TvMovie(genreID: 10770),
  Thriller(genreID: 53),
  War(genreID: 10752),
  Western(genreID: 37),
  All(genreID: -1);
  final int genreID;
  const MovieGenreEnum({required this.genreID});
}



