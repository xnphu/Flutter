import 'package:flutter_quanly_nhanvien/models/models.dart';

abstract class DetailRoomState {
}

class DetailRoomInitialState extends DetailRoomState {
  final List<Officer> officers;

  DetailRoomInitialState({this.officers});

}

class DetailRoomLoadInProgressState extends DetailRoomState {}

class DetailRoomLoadSuccessState extends DetailRoomState {
  final List<Officer> officers;

  DetailRoomLoadSuccessState({this.officers});

}

class DetailRoomLoadFailureState extends DetailRoomState {}

class RemoveSuccessState extends DetailRoomState {
  final List<Officer> officers;

  RemoveSuccessState({this.officers});
}
