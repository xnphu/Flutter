import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';

class DetailRoomInitialEvent extends BaseEvent {
  final int index;

  DetailRoomInitialEvent({this.index});
}

class DeleteOfficerEvent extends BaseEvent {
  final int index;
  final int roomIndex;

  DeleteOfficerEvent({this.index, this.roomIndex});
}

class EditOfficerEvent extends BaseEvent {
  final int index;
  final int roomIndex;
  final String name;
  final String gender;

  EditOfficerEvent({this.index, this.roomIndex, this.name, this.gender});
}

