import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RoomInitialState extends RoomState {}

class RoomLoadInProgressState extends RoomState {}

class RoomLoadSuccessState extends RoomState {
  final List<Room> rooms;

  RoomLoadSuccessState({this.rooms}) : super();

  @override
  // TODO: implement props
  List<Object> get props => [rooms];

  @override
  String toString() => 'RoomLoadSuccess { rooms: $rooms }';
}

class RoomLoadFailureState extends RoomState {}