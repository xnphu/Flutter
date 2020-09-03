import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

class SetPositionLoadSuccessState extends BaseState {
  final List<Officer> officers;

  SetPositionLoadSuccessState({this.officers});
}

class SetPositionFailureState extends BaseState {}
