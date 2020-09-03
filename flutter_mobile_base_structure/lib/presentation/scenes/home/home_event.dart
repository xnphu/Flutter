import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';

class HomeInitialEvent extends BaseEvent {}

class HomeLoadSuccessEvent extends BaseEvent {}

class AddRoomEvent extends BaseEvent {
  final Room room;

  AddRoomEvent(this.room);
}

class DeleteRoomEvent extends BaseEvent {
  final int index;

  DeleteRoomEvent({this.index});
}

class AddOfficerToRoomEvent extends BaseEvent {
  final int roomIndex;
  final Officer officer;

  AddOfficerToRoomEvent({this.roomIndex, this.officer});
}

class HomeLoadFailureEvent extends BaseEvent {}

class LogOutEvent extends BaseEvent {}
