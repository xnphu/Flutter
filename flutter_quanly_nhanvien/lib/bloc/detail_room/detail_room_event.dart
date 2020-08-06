import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class DetailRoomEvent extends Equatable {
  const DetailRoomEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailRoomInitialEvent extends DetailRoomEvent {
  final List<Officer> officers;

  DetailRoomInitialEvent({this.officers});

  @override
  // TODO: implement props
  List<Object> get props => [officers];

  @override
  String toString() => 'Detail room data initial with officers { $officers }';
}

class DeleteOfficerEvent extends DetailRoomEvent {
  final int index;

  DeleteOfficerEvent({this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];

  @override
  String toString() => 'Deleted officer at index: { $index }';
}
