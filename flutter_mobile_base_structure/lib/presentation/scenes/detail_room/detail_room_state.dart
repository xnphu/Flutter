import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

class DetailRoomLoadSuccessState extends BaseState {
  final List<Officer> officerList;

  DetailRoomLoadSuccessState({this.officerList});
}

class DetailRoomLoadInProgressState extends BaseState {}

class DetailRoomLoadFailureState extends BaseState {}