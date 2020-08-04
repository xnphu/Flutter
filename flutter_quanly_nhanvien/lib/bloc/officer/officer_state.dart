import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class OfficerState extends Equatable {
  const OfficerState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OfficerInitialState extends OfficerState {}

class OfficerLoadInProgressState extends OfficerState {}

class OfficerLoadSuccessState extends OfficerState {
  final List<Officer> officers;

  OfficerLoadSuccessState({this.officers});

  @override
  // TODO: implement props
  List<Object> get props => [officers];

  @override
  String toString() => 'OfficerLoadSuccess { officers: $officers }';
}

class OfficerLoadFailureState extends OfficerState {}