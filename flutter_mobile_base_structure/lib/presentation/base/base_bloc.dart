import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'base_event.dart';
import 'base_state.dart';

export 'package:flutter_mobile_base_structure/presentation/resources/localization/app_localization.dart';
export 'package:rxdart/rxdart.dart';
export 'package:flutter_mobile_base_structure/presentation/scenes/navigator/page_navigator.dart';
export 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';
export 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
export 'package:flutter_mobile_base_structure/core/validations.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<BaseEvent, BaseState> {
  void dispose();

  void dispatchEvent(BaseEvent event) {
    assert(event != null);
    // print('dispatchEvent event $event');
    super.add(event);
  }
}
