import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class DetailRoomState extends Equatable {
  const DetailRoomState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailRoomInitialState extends DetailRoomState {
  final List<Officer> officers;

  DetailRoomInitialState({this.officers}) : super();

  @override
  // TODO: implement props
  List<Object> get props => [officers];

  @override
  String toString() => 'DetailRoomInitial { officers: $officers }';
}

class DetailRoomLoadInProgressState extends DetailRoomState {}

class DetailRoomLoadSuccessState extends DetailRoomState {
  final List<Officer> officers;

  DetailRoomLoadSuccessState({this.officers}) : super();

  @override
  // TODO: implement props
  List<Object> get props => [officers];

  @override
  String toString() => 'DetailRoomLoadSuccess { officers: $officers }';
}

class DetailRoomLoadFailureState extends DetailRoomState {}
