import 'package:cinema_app/data/models/genre/genre_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GenreAdapter extends TypeAdapter<GenreModel>{
  @override
  GenreModel read(BinaryReader reader) {
    return GenreModel(
        id: reader.readInt(),
        name: reader.readString(),
    );
  }

  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, GenreModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
  }

}