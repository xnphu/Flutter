import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class OfficerEvent extends Equatable {
  const OfficerEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OfficerLoadSuccessEvent extends OfficerEvent {}

class OfficerAddedEvent extends OfficerEvent {
  final Officer officer;

  OfficerAddedEvent(this.officer);

  @override
  // TODO: implement props
  List<Object> get props => [officer];

  @override
  String toString() => 'OfficerAdded { officer: $officer }';
}

class OfficerDeletedEvent extends OfficerEvent {
  final int index;

  OfficerDeletedEvent({this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];

  @override
  String toString() => 'OfficerDeletedIndex { officerIndex: $index }';
}
