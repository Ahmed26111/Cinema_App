import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TicketAdapter extends TypeAdapter<TicketModel> {
  @override
  TicketModel read(BinaryReader reader) {
    return TicketModel(
        ticketId: reader.readString(),
        userId: reader.readString(),
        movieId: reader.readInt(),
        movieName: reader.readString(),
        seatNumber: reader.readString(),
        date: reader.read() as DateTime,
        time: reader.readString(),
        price: reader.readDouble(),
        hallName: reader.readString()
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, TicketModel obj) {
    writer.writeString(obj.ticketId);
    writer.writeString(obj.userId);
    writer.writeInt(obj.movieId);
    writer.writeString(obj.movieName);
    writer.writeString(obj.seatNumber);
    writer.write(obj.date);
    writer.writeString(obj.time);
    writer.writeDouble(obj.price);
    writer.writeString(obj.hallName);
  }

}