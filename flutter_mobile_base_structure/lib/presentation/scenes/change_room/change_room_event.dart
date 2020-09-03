import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';

class ChangeRoomInitialEvent extends BaseEvent {}

class SetRoomChoiceInitialEvent extends BaseEvent {
  final Officer officer;

  SetRoomChoiceInitialEvent({this.officer});
}

class SetRoomChoiceEvent extends BaseEvent {
  final String roomChoice;
  final Officer officer;

  SetRoomChoiceEvent({this.roomChoice, this.officer});
}

class ChangeRoomLoadSuccessEvent extends BaseEvent {}

class ChangeRoomFailureEvent extends BaseEvent {}
