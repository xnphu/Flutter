import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

class HomeLoadSuccessState extends BaseState {
  final List<Room> rooms;

  HomeLoadSuccessState({this.rooms});
}

class HomeLoadInProgressState extends BaseState {}

class HomeLoadFailureState extends BaseState {}
