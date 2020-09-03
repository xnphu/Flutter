import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';

class SetPositionInitialEvent extends BaseEvent {
  final int roomIndex;

  SetPositionInitialEvent({this.roomIndex});
}

class SetTruongPhongEvent extends BaseEvent {
  final int roomIndex;
  final int officerIndex;

  SetTruongPhongEvent({this.roomIndex, this.officerIndex});
}

class SetPhoPhongEvent extends BaseEvent {
  final int roomIndex;
  final int officerIndex;
  final bool isSelected;

  SetPhoPhongEvent({this.roomIndex, this.officerIndex, this.isSelected});
}

class SetPositionLoadSuccessEvent extends BaseEvent {}

class SetPositionFailureEvent extends BaseEvent {}