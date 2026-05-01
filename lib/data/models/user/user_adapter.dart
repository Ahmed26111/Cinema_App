import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
        firstName: reader.readString(),
        lastName: reader.readString(),
        email: reader.readString(),
        password: reader.readString(),
        userId: reader.readString(),
        favouritesMoviesIds: reader.readIntList().cast<int>(),
        watchListMoviesIds: reader.readIntList().cast<int>(),
        tickets: reader.readList().cast<TicketModel>(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.email);
    writer.writeString(obj.password);
    writer.writeString(obj.userId);
    writer.writeIntList(obj.favouritesMoviesIds);
    writer.writeIntList(obj.watchListMoviesIds);
    writer.writeList(obj.tickets);
  }

}