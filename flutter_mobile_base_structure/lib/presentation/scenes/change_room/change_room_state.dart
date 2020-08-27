import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

class ChangeRoomLoadSuccessState extends BaseState {
  final List<Room> rooms;

  ChangeRoomLoadSuccessState({this.rooms});
}

class ChangeRoomLoadInProgressState extends BaseState {}

class ChangeRoomLoadFailureState extends BaseState {}
