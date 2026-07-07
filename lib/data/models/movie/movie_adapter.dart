import 'package:cinema_app/data/models/company/company_model.dart';
import 'package:cinema_app/data/models/genre/genre_model.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieAdapter extends TypeAdapter<MovieModel>{

  @override
  MovieModel read(BinaryReader reader) {
    return MovieModel(
      isAdult: reader.readBool(),
      movieId: reader.readInt(),
      runTime: reader.readInt(),
      voteAverage: reader.readDouble(),
      movieTitle: reader.readString(),
      overview: reader.readString(),
      originalLanguage: reader.readString(),
      posterPathImage: reader.readString(),
      status: reader.readString(),
      backdropPathImage: reader.readString(),
      tagLine: reader.readString(),
      imdbId: reader.readString(),
      genreIds: reader.readIntList(),
      originCountry: reader.readStringList(),
      productionCompanies: reader.readList().cast<CompanyModel>(),
      genres: reader.readList().cast<GenreModel>(),
      releaseDate: reader.read() as DateTime,
    );
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer.writeBool(obj.isAdult);
    writer.writeInt(obj.movieId);
    writer.writeInt(obj.runTime ?? 0);
    writer.writeDouble(obj.voteAverage);
    writer.writeString(obj.movieTitle);
    writer.writeString(obj.overview);
    writer.writeString(obj.originalLanguage);
    writer.writeString(obj.posterPathImage ?? "");
    writer.writeString(obj.status ?? "");
    writer.writeString(obj.backdropPathImage ?? "");
    writer.writeString(obj.tagLine ?? "");
    writer.writeString(obj.imdbId ?? "");
    writer.writeIntList(obj.genreIds ?? <int>[]);
    writer.writeStringList(obj.originCountry ?? <String>[]);
    writer.writeList(obj.productionCompanies ?? []);
    writer.writeList(obj.genres ?? []);
    writer.write(obj.releaseDate);
  }

}