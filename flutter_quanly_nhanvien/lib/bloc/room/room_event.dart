import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RoomLoadSuccessEvent extends RoomEvent {}

class RoomAddedEvent extends RoomEvent {
  final Room room;

  RoomAddedEvent(this.room);

  @override
  // TODO: implement props
  List<Object> get props => [room];

  @override
  String toString() => 'RoomAdded { room: $room }';
}

class RoomDeletedEvent extends RoomEvent {
  final int index;

  RoomDeletedEvent({this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];

  @override
  String toString() => 'RoomDeletedIndex { roomIndex: $index }';
}

class AddOfficerToRoomEvent extends RoomEvent {
  final int roomId;
  final String maNhanVien;
  final String tenNhanVien;

  AddOfficerToRoomEvent({this.roomId, this.maNhanVien, this.tenNhanVien});

  @override
  // TODO: implement props
  List<Object> get props => [roomId, maNhanVien, tenNhanVien];

  @override
  String toString() =>
      'Added officer { id: $maNhanVien, name: $tenNhanVien } to roomId $roomId }';
}
