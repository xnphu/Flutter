import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';

class SetPositionBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) {
    // TODO: implement mapEventToState

  }

}