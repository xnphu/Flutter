import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

class ChangeRoomLoadSuccessState extends BaseState {
  final List<Room> rooms;
  final String roomChoice;
  ChangeRoomLoadSuccessState({this.roomChoice, this.rooms});
}

class RoomChoiceLoadSuccessState extends BaseState {
  final String roomChoice;

  RoomChoiceLoadSuccessState({this.roomChoice});
}

class ChangeRoomLoadInProgressState extends BaseState {}

class ChangeRoomLoadFailureState extends BaseState {}
