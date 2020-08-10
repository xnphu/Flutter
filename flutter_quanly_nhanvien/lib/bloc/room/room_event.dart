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
  final int roomIndex;
  final Officer officer;

  AddOfficerToRoomEvent({this.roomIndex, this.officer});

  @override
  // TODO: implement props
  List<Object> get props => [roomIndex, officer];

  @override
  String toString() =>
      'Added officer { $officer } to roomIndex: $roomIndex';
}

class RoomModifyEvent extends RoomEvent {
  final int roomIndex;
  final List<Officer> officerNewList;

  RoomModifyEvent({this.roomIndex, this.officerNewList});

  @override
  // TODO: implement props
  List<Object> get props => [roomIndex, officerNewList];

  @override
  String toString() =>
      'RoomModify index { $roomIndex } new officer list: $officerNewList';
}
