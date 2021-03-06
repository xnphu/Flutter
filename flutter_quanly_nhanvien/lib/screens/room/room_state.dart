import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class RoomState {}

class RoomInitialState extends RoomState {}

class RoomLoadInProgressState extends RoomState {}

class RoomLoadSuccessState extends RoomState {
  final List<Room> rooms;
  RoomLoadSuccessState({this.rooms});
}

class RoomChoiceLoadSuccessState extends RoomState {
  final String roomChoice;
  RoomChoiceLoadSuccessState({this.roomChoice});
}

class RoomModifyState extends RoomState {
  final List<Room> rooms;

  RoomModifyState({this.rooms});
}

class ChangeRoomState extends RoomState {
  final List<Room> rooms;

  ChangeRoomState({this.rooms});
}

class SetPositionScreenLoadSuccessState extends RoomState {
  final List<Officer> officers;

  SetPositionScreenLoadSuccessState({this.officers});
}

class SetPhoPhongSuccessState extends RoomState {
  final List<Officer> officers;

  SetPhoPhongSuccessState({this.officers});
}

class RoomLoadFailureState extends RoomState {}