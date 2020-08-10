import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class RoomState {}

class RoomInitialState extends RoomState {}

class RoomLoadInProgressState extends RoomState {}

class RoomLoadSuccessState extends RoomState {
  final List<Room> rooms;

  RoomLoadSuccessState({this.rooms});
}

class RoomModifyState extends RoomState {
  final List<Room> rooms;

  RoomModifyState({this.rooms});
}

class RoomLoadFailureState extends RoomState {}