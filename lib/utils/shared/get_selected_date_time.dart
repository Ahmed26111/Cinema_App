DateTime getSelectedDateTime(DateTime movieReleaseDate){
  return (DateTime.now().compareTo(movieReleaseDate) <= 0) ? movieReleaseDate : DateTime.now();
}